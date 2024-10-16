defmodule GoChampsScoreboard.EventHandlers.UpdateTeamStatTest do
  use ExUnit.Case
  alias GoChampsScoreboard.EventHandlers.UpdateTeamStat
  alias GoChampsScoreboard.Games.Models.GameState

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

    assert UpdateTeamStat.handle(@initial_state, payload) == expected_state
  end
end
