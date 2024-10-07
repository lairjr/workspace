defmodule Components.BasketballControls.PlayerStats do
  use Phoenix.Component

  def stats_control(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <p><%= @selected_player.player_id %></p>
      </div>
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
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
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
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
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
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
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
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
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
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
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
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
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
            class={
              ["button", "is-medium", "is-fullwidth"] ++
                [if(player.id == @selected_player.player_id, do: "is-dark", else: "")]
            }
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
        <.team_players
          players={@game_state.home_team.players}
          team_type="home"
          selected_player={@selected_player}
        />
        <button
          class="button"
          phx-click="show-add-player-to-team"
          phx-value-team-type="home"
        >
          Add player
        </button>
      </div>

      <div class="column">
        <.stats_control selected_player={@selected_player} />
      </div>

      <div class="column">
        <.team_players
          players={@game_state.away_team.players}
          team_type="away"
          selected_player={@selected_player}
        />
        <button
          class="button"
          phx-click="show-add-player-to-team"
          phx-value-team-type="away"
        >
          Add player
        </button>
      </div>
    </div>
    """
  end
end
