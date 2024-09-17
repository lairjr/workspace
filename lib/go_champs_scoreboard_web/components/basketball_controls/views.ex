defmodule Components.BasketballControls.Views do
  alias GoChampsScoreboard.Games.Models.GameState
  use Phoenix.Component

  attr :game_state, GameState, required: true

  def general(assigns) do
    ~H"""
    <div class="container">
      <.teams_header game_state={@game_state} />
      <Components.BasketballControls.PlayerStats.view game_state={@game_state} />
    </div>
    """
  end

  def teams_header(assigns) do
    ~H"""
    <div class="columns basketball-teams-header">
      <div class="column home-team">
        <div class="columns">
          <div class="column has-text-right">
            <h3 class="title is-3">
              <%= @game_state.home_team.name %>
            </h3>
          </div>
          <div class="column is-2 has-text-right">
            <h3 class="title is-3">
              <%= @game_state.home_team.score %>
            </h3>
          </div>
        </div>
      </div>

      <div class="column away-team">
        <div class="columns">
          <div class="column is-2">
            <h3 class="title is-3">
              <%= @game_state.away_team.score %>
            </h3>
          </div>
          <div class="column">
            <h3 class="title is-3">
              <%= @game_state.away_team.name %>
            </h3>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
