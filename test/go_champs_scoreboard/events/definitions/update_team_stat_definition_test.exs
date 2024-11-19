defmodule GoChampsScoreboard.Events.Definitions.UpdateTeamStatDefinitionTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Events.Definitions.UpdateTeamStatDefinition
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState

  describe "validate/2" do
    test "returns :ok" do
      game_state = %GameState{
        home_team: %{
          players: [
            %{
              id: "123",
              stats_values: %{}
            }
          ]
        },
        away_team: %{
          players: [
            %{id: "456", stats_values: %{}}
          ]
        }
      }

      assert {:ok} =
               UpdateTeamStatDefinition.validate(game_state, %{
                 "operation" => "increment",
                 "team-type" => "home",
                 "stat-id" => "fouls_technical"
               })
    end
  end

  describe "create/2" do
    test "returns event" do
      assert %Event{key: "update-team-stat", game_id: "some-game-id"} =
               UpdateTeamStatDefinition.create("some-game-id", %{
                 "operation" => "increment",
                 "team-type" => "home",
                 "stat-id" => "fouls_technical"
               })
    end
  end

  describe "handle/2" do
    @initial_state %GameState{
      home_team: %{
        players: [
          %{
            id: "123",
            stats_values: %{}
          }
        ],
        total_player_stats: %{},
        stats_values: %{
          "fouls_technical" => 1,
          "total_fouls_technical" => 1
        }
      },
      away_team: %{
        players: [
          %{id: "456", stats_values: %{}}
        ],
        total_player_stats: %{},
        stats_values: %{}
      },
      sport_id: "basketball"
    }

    test "increments team stats for home team" do
      payload = %{
        "operation" => "increment",
        "team-type" => "home",
        "stat-id" => "fouls_technical"
      }

      event = UpdateTeamStatDefinition.create("game-id", payload)

      expected_state = %GameState{
        home_team: %{
          players: [
            %{
              id: "123",
              stats_values: %{}
            }
          ],
          total_player_stats: %{},
          stats_values: %{
            "fouls_technical" => 2,
            "total_fouls_technical" => 2
          }
        },
        away_team: %{
          players: [
            %{id: "456", stats_values: %{}}
          ],
          total_player_stats: %{},
          stats_values: %{}
        },
        sport_id: "basketball"
      }

      assert UpdateTeamStatDefinition.handle(@initial_state, event) == expected_state
    end
  end
end
