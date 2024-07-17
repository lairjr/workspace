defmodule GoChampsScoreboardWeb.GameAdminLive do
  use GoChampsScoreboardWeb, :live_view
  require Logger

  def mount(_params, _session, socket) do
    game = Games.find("game-id")

    if (connected?(socket)) do
      Games.subscribe("game-id")
    end

    socket = assign(socket, game_state: game)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div>
        <p>Team: <%= @game_state.away_team.name %></p>
        <p>Score: <%= @game_state.away_team.score %></p>
        <p><button class="btn" phx-click="inc_away">+1</button></p>
      </div>

      <div>
        <p>Team: <%= @game_state.home_team.name %></p>
        <p>Score: <%= @game_state.home_team.score %></p>
        <p><button class="btn" phx-click="inc_home">+1</button></p>
      </div>
    </div>
    """
  end

  def handle_event("inc_away", _value, socket) do
    {:ok, new_game} = Games.inc_away(socket.assigns.game_state)
    {:noreply, assign(socket, game_state: new_game)}
  end

  def handle_event("inc_home", _value, socket) do
    {:ok, new_game} = Games.inc_home(socket.assigns.game_state)
    {:noreply, assign(socket, game_state: new_game)}
  end

  def handle_info({:update_game, game}, socket) do
    {:noreply, assign(socket, game_state: game)}
  end
end
