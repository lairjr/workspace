defmodule GoChampsScoreboard.GameClock do
  use GenServer

  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: via_tuple(game_id))
  end

  def init(game_id) do
    schedule_tick()
    {:ok, %{game_id: game_id, time: ~T[00:00:00]}}
  end

  def handle_info(:tick, state) do
    new_time = Time.add(state.time, 1)
    schedule_tick()
    {:noreply, %{state | time: new_time}}
  end

  defp schedule_tick() do
    Process.send_after(self(), :tick, 1000)
  end

  def get_time(game_id) do
    GenServer.call(via_tuple(game_id), :get_time)
  end

  def handle_call(:get_time, _from, state) do
    {:reply, state.time, state}
  end

  defp via_tuple(game_id) do
    {:via, Registry, {GoChampsScoreboard.GameRegistry, game_id}}
  end
end
