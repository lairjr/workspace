defmodule GoChampsScoreboard.Infrastructure.GameTicker do
  use GenServer
  require Logger
  alias GoChampsScoreboard.Events.Definitions.GameTickDefinition
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Events.ValidatorCreator

  def start_link([game_id]) do
    start_link(game_id)
  end

  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: via_tuple(game_id))
  end

  @impl true
  def init(game_id) do
    schedule_tick()
    {:ok, %{game_id: game_id, time: ~T[00:00:00]}}
  end

  @impl true
  def handle_info(:tick, state) do
    new_time = Time.add(state.time, 1)

    {:ok, event} =
      GameTickDefinition.key()
      |> ValidatorCreator.validate_and_create(state.game_id, %{time: new_time})

    event
    |> Games.react_to_event(state.game_id)

    schedule_tick()
    {:noreply, %{state | time: new_time}}
  end

  defp schedule_tick() do
    Process.send_after(self(), :tick, 1000)
  end

  def stop(game_id) do
    GenServer.stop(via_tuple(game_id))
  end

  def get_time(game_id) do
    GenServer.call(via_tuple(game_id), :get_time)
  end

  @impl true
  def handle_call(:get_time, _from, state) do
    {:reply, state.time, state}
  end

  defp via_tuple(game_id) do
    {:via, Registry, {GoChampsScoreboard.Infrastructure.GameTickerRegistry, game_id}}
  end

  @impl true
  def terminate(reason, state) do
    IO.inspect("GameTicker for game #{state.game_id} terminated with reason: #{inspect(reason)}")

    Logger.error(
      "GameTicker for game #{state.game_id} terminated abruptly with reason: #{inspect(reason)}"
    )

    :ok
  end
end
