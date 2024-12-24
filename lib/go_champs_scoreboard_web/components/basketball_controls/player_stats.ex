defmodule Components.BasketballControls.PlayerStats do
  use Phoenix.Component

  def stats_control(assigns) do
    ~H"""
    <div class="columns is-multiline">
      <div class="column is-12">
        <p>{@selected_player.player_id}</p>
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
                      phx-value-stat-id="free_throws_made"
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
                    >
                      Made 1
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="field_goals_made"
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
                    >
                      Made 2
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="three_point_field_goals_made"
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
                    >
                      Made 3
                    </button>
                  </div>
                </div>

                <div class="column is-12">
                  <div class="columns">
                    <div class="column has-text-centered">
                      <button
                        class="button is-danger"
                        phx-click="update-player-stat"
                        phx-value-stat-id="free_throws_missed"
                        phx-value-operation="increment"
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
                      >
                        Miss 1
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button
                        class="button is-danger"
                        phx-click="update-player-stat"
                        phx-value-stat-id="field_goals_missed"
                        phx-value-operation="increment"
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
                      >
                        Miss 2
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button
                        class="button is-danger"
                        phx-click="update-player-stat"
                        phx-value-stat-id="three_point_field_goals_missed"
                        phx-value-operation="increment"
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
                      >
                        Miss 3
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
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="rebounds_offensive"
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
                    >
                      +1 Reb Off
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="rebounds_defensive"
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
                    >
                      >
                      +1 Reb Def
                    </button>
                  </div>
                  <div class="column has-text-centered">
                    <button
                      class="button is-large is-info"
                      phx-click="update-player-stat"
                      phx-value-stat-id="assists"
                      phx-value-operation="increment"
                      phx-value-player-id={@selected_player.player_id}
                      phx-value-team-type={@selected_player.team_type}
                    >
                      >
                      +1 Ass
                    </button>
                  </div>
                </div>

                <div class="column is-12">
                  <div class="columns">
                    <div class="column has-text-centered">
                      <button
                        class="button is-large is-info"
                        phx-click="update-player-stat"
                        phx-value-stat-id="blocks"
                        phx-value-operation="increment"
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
                      >
                        >
                        +1 Block
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button
                        class="button is-large is-info"
                        phx-click="update-player-stat"
                        phx-value-stat-id="steals"
                        phx-value-operation="increment"
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
                      >
                        >
                        +1 Steal
                      </button>
                    </div>
                    <div class="column has-text-centered">
                      <button
                        class="button is-large is-info"
                        phx-click="update-player-stat"
                        phx-value-stat-id="turnovers"
                        phx-value-operation="increment"
                        phx-value-player-id={@selected_player.player_id}
                        phx-value-team-type={@selected_player.team_type}
                      >
                        >
                        +1 TO
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
            {player.name}
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
        <button class="button" phx-click="show-add-player-to-team" phx-value-team-type="home">
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
        <button class="button" phx-click="show-add-player-to-team" phx-value-team-type="away">
          Add player
        </button>
      </div>
    </div>
    """
  end
end
