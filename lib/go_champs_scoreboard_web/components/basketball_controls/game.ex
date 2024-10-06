defmodule Components.BasketballControls.Game do
  use Phoenix.Component

  def time_controls(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12 has-text-centered">
        <button class="button">
          <%= "<" %>
        </button>

        <button class="button">
          2o
        </button>

        <button class="button">
          <%= ">" %>
        </button>
      </div>

      <div class="column is-12 has-text-centered">
        <button class="button">
          <%= "<" %>
        </button>

        <button class="button">
          09:21:32
        </button>

        <button class="button">
          <%= ">" %>
        </button>
      </div>

      <div class="column is-12 has-text-centered">
        <button class="button">
          Start
        </button>

        <button class="button">
          Pause
        </button>
      </div>
    </div>
    """
  end

  def home_team_totals(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <button class="button">
          Active log
        </button>

        <button class="button">
          Undo
        </button>

        <button class="button">
          T. Foul
        </button>
      </div>

      <div class="column is-12 has-text-right">
        <button
          class="button"
          phx-click={GoChampsScoreboardWeb.CoreComponents.show_modal("team_box_score")}
        >
          Box score
        </button>

        <button class="button is-large" phx-click="select-team" phx-value-team-type="home">
          <%= @game_state.home_team.name %>
        </button>

        <button class="button is-large">
          <%= @game_state.home_team.score %>
        </button>
      </div>
    </div>
    """
  end

  def away_team_totals(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12"></div>

      <div class="column is-12">
        <button class="button is-large">
          <%= @game_state.away_team.score %>
        </button>

        <button class="button is-large" phx-click="select-team" phx-value-team-type="away">
          <%= @game_state.away_team.name %>
        </button>

        <button
          class="button"
          phx-click={GoChampsScoreboardWeb.CoreComponents.show_modal("team_box_score")}
        >
          Box score
        </button>
      </div>
    </div>
    """
  end

  def main(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <div class="columns">
          <div class="column is-4">
            <Components.BasketballControls.Game.home_team_totals game_state={@game_state} />
          </div>

          <div class="column is-4 has-text-centered">
            <Components.BasketballControls.Game.time_controls />
          </div>

          <div class="column is-4">
            <Components.BasketballControls.Game.away_team_totals game_state={@game_state} />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
