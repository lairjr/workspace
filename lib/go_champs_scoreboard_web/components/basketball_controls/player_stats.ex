defmodule Components.BasketballControls.PlayerStats do
  alias GoChampsScoreboard.Games.Models.PlayerState
  use Phoenix.Component

  attr :player, PlayerState, required: true

  def row(assigns) do
    ~H"""
      <p>Player name, <%= @player.name %>!</p>
      <p>
        <button
          class="button"
          phx-click="update-player-stat"
          phx-value-stat-id="points"
          phx-value-operation="+"
          phx-value-amount="1"
          phx-value-team-type="away"
          phx-value-player-id={@player.id}
        >
          +1
        </button>
      </p>
      <p>
        <button
          class="button"
          phx-click="update-player-stat"
          phx-value-stat-id="points"
          phx-value-operation="+"
          phx-value-amount="2"
          phx-value-team-type="away"
          phx-value-player-id={@player.id}
        >
          +2
        </button>
      </p>
      <p>
        <button
          class="button"
          phx-click="update-player-stat"
          phx-value-stat-id="points"
          phx-value-operation="+"
          phx-value-amount="3"
          phx-value-team-type="away"
          phx-value-player-id={@player.id}
        >
          +3
        </button>
      </p>
      <p>
        <button
          class="button"
          phx-click="update-player-stat"
          phx-value-stat-id="points"
          phx-value-operation="-"
          phx-value-amount="1"
          phx-value-team-type="away"
          phx-value-player-id={@player.id}
        >
          -1
        </button>
      </p>
      <p>
        <button
          class="button"
          phx-click="update-player-stat"
          phx-value-stat-id="points"
          phx-value-operation="-"
          phx-value-amount="2"
          phx-value-team-type="away"
          phx-value-player-id={@player.id}
        >
          -2
        </button>
      </p>
      <p>
        <button
          class="button"
          phx-click="update-player-stat"
          phx-value-stat-id="points"
          phx-value-operation="-"
          phx-value-amount="3"
          phx-value-team-type="away"
          phx-value-player-id={@player.id}
        >
          -3
        </button>
      </p>
    """
  end

  def view(assigns) do
    ~H"""
      <div class="columns">
        <div class="column">
          Home players
        </div>

        <div class="column">
          Stats
        </div>

        <div class="column">
          Away players
        </div>
      </div>
    """
  end
end
