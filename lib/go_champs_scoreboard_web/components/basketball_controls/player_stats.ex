defmodule Components.BasketballControls.PlayerStats do
  use Phoenix.Component

  def stats_control(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <nav class="panel">
          <p class="panel-heading">Points</p>
          <div class="panel-block is-justify-content-center">
            <div class="columns is-multiline">
              <div class="column is-12">
                <div class="columns">
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="points"
                      phx-value-operation="+"
                      phx-value-amount="1"
                    >
                      +1
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="points"
                      phx-value-operation="+"
                      phx-value-amount="2"
                    >
                      +2
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="points"
                      phx-value-operation="+"
                      phx-value-amount="3"
                    >
                      +3
                    </button>
                  </div>
                </div>

                <div class="column is-12">
                  <div class="columns">
                    <div class="column has-text-centered">
                      <button
                        class="button is-danger"
                        phx-click="update-player-stat"
                        phx-value-stat-id="points"
                        phx-value-operation="-"
                        phx-value-amount="1"
                      >
                        -1
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button
                        class="button is-danger"
                        phx-click="update-player-stat"
                        phx-value-stat-id="points"
                        phx-value-operation="-"
                        phx-value-amount="2"
                      >
                        -2
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button
                        class="button is-danger"
                        phx-click="update-player-stat"
                        phx-value-stat-id="points"
                        phx-value-operation="-"
                        phx-value-amount="3"
                      >
                        -3
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </nav>
      </div>

      <div class="column is-12">
        <nav class="panel">
          <p class="panel-heading">Other stats</p>
          <div class="panel-block is-justify-content-center">
            <div class="columns is-multiline">
              <div class="column is-12">
                <div class="columns">
                  <div class="column has-text-centered">
                    <button class="button is-large is-info">
                      +1 Reb
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button class="button is-large is-info">
                      +1 Ass
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button class="button is-large is-info">
                      +1 TO
                    </button>
                  </div>
                </div>

                <div class="column is-12">
                  <div class="columns">
                    <div class="column has-text-centered">
                      <button class="button is-danger">
                        -1 Reb
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button class="button is-danger">
                        -1 Ass
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button class="button is-danger">
                        -1 TO
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </nav>
      </div>
    </div>
    """
  end

  def team_players(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <%= for player <- @players do %>
        <div class="column is-12">
          <button
            class="button is-medium is-fullwidth"
            phx-click="select-player"
            phx-value-player-id={player.id}
            phx-value-team-type={@team_type}
          >
            <%= player.name %>
          </button>
        </div>
      <% end %>
    </div>
    """
  end

  def view(assigns) do
    ~H"""
    <div class="columns">
      <div class="column">
        <.team_players players={@game_state.home_team.players} team_type="home" />
      </div>

      <div class="column">
        <.stats_control />
      </div>

      <div class="column">
        <.team_players players={@game_state.away_team.players} team_type="away" />
      </div>
    </div>
    """
  end
end
