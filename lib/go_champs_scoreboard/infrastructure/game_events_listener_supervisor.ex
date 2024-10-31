defmodule GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisor do
  use DynamicSupervisor

  @behaviour GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisorBehavior

  @two_days_in_milliseconds 172_800_000

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @impl true
  def start_game_events_listener(game_id) do
    child_spec = %{
      id: game_id,
      start: {GoChampsScoreboard.Infrastructure.GameEventsListener, :start_link, [game_id]},
      type: :worker,
      restart: :transient,
      shutdown: @two_days_in_milliseconds
    }

    result = DynamicSupervisor.start_child(__MODULE__, child_spec)
    IO.inspect(result)
  end

  @impl true
  def stop_game_events_listener(game_id) do
    case Registry.lookup(GoChampsScoreboard.Infrastructure.GameEventsListenerRegistry, game_id) do
      [{pid, _}] ->
        DynamicSupervisor.terminate_child(__MODULE__, pid)

      [] ->
        {:error, :not_found}
    end
  end

  def stop_all_game_events_listeners do
    Registry.select(GoChampsScoreboard.Infrastructure.GameEventsListenerRegistry, [
      {{:"$1", :"$2", :"$3"}, [], [:"$1"]}
    ])
    |> Enum.each(fn pid ->
      DynamicSupervisor.terminate_child(__MODULE__, pid)
    end)
  end
end
