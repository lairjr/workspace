defmodule GoChampsScoreboard.Infrastructure.GameEventsListener do
  use GenServer
  alias GoChampsScoreboard.Games.Messages.PubSub

  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: via_tuple(game_id))
  end

  def init(game_id) do
    PubSub.subscribe(game_id)

    {:ok, %{game_id: game_id}}
  end

  def handle_info({:update_game, game_state}, state) do
    IO.inspect(game_state)
    {:noreply, state}
  end

  defp via_tuple(game_id) do
    {:via, Registry, {GoChampsScoreboard.Infrastructure.GameEventsListenerRegistry, game_id}}
  end
end
