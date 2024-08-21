defmodule GoChampsScoreboardWeb.GameAdminLive do
  alias GoChampsScoreboard.Games.Games
  use GoChampsScoreboardWeb, :live_view
  require Logger

  def mount(%{"game_id" => game_id}, _session, socket) do
    if (connected?(socket)) do
      Games.subscribe(game_id)
    end

    {:ok,
      socket
      |> assign_async(:game_state, fn -> {:ok, %{game_state: Games.find_or_bootstrap(game_id)}} end)
    }
  end

  def handle_event("inc_score", _value, socket) do
    # {:ok, new_game} = Games.inc_away(socket.assigns.game_state)
    Logger.info("Inc score Event")
    {:noreply, socket}
  end

  def handle_info({:update_game, game}, socket) do
    {:noreply, assign(socket, game_state: game)}
  end
end
