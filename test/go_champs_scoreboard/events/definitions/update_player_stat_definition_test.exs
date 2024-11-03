defmodule GoChampsScoreboard.Events.Definitions.UpdatePlayerStatDefinitionTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Events.Definitions.UpdatePlayerStatDefinition
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState

  describe "validate_and_create/0" do
    test "returns :ok and event" do
      assert {:ok, %Event{key: "update-player-stat"}} =
               UpdatePlayerStatDefinition.validate_and_create(%{
                 "operation" => "increment",
                 "team-type" => "home",
                 "player-id" => "123",
                 "stat-id" => "two-points-made"
               })
    end
  end

  describe "handle/2" do
    @initial_state %GameState{
      home_team: %{
        players: [
          %{
            id: "123",
            stats_values: %{
              "two-points-made" => 1,
              "points" => 2,
              "rebounds" => 0
            }
          }
        ],
        total_player_stats: %{
          "two-points-made" => 1,
          "points" => 2,
          "rebounds" => 0
        }
      },
      away_team: %{
        players: [
          %{id: "456", stats_values: %{}}
        ],
        total_player_stats: %{}
      },
      sport_id: "basketball"
    }

    test "increments player stats for home team" do
      payload = %{
        "operation" => "increment",
        "team-type" => "home",
        "player-id" => "123",
        "stat-id" => "two-points-made"
      }

      {:ok, event} = UpdatePlayerStatDefinition.validate_and_create(payload)

      expected_state = %GameState{
        home_team: %{
          players: [
            %{
              id: "123",
              stats_values: %{
                "two-points-made" => 2,
                "points" => 4,
                "rebounds" => 0
              }
            }
          ],
          total_player_stats: %{
            "two-points-made" => 2,
            "points" => 4,
            "rebounds" => 0
          }
        },
        away_team: %{
          players: [
            %{id: "456", stats_values: %{}}
          ],
          total_player_stats: %{}
        },
        sport_id: "basketball"
      }

      assert UpdatePlayerStatDefinition.handle(@initial_state, event) == expected_state
    end
  end
end
