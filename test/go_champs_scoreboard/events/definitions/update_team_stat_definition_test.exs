defmodule GoChampsScoreboard.Events.Definitions.UpdateTeamStatDefinitionTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Events.Definitions.UpdateTeamStatDefinition
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState

  describe "validate_and_create/1" do
    test "returns :ok and event" do
      assert {:ok, %Event{key: "update-team-stat"}} =
               UpdateTeamStatDefinition.validate_and_create(%{
                 "operation" => "increment",
                 "team-type" => "home",
                 "stat-id" => "technical-fouls"
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
          "technical-fouls" => 1,
          "total-technical-fouls" => 1
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
        "stat-id" => "technical-fouls"
      }

      {:ok, event} = UpdateTeamStatDefinition.validate_and_create(payload)

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
            "technical-fouls" => 2,
            "total-technical-fouls" => 2
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
