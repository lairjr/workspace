defmodule GoChampsScoreboard.EventHandles.UpdatePlayerStatTest do
  use ExUnit.Case
  alias GoChampsScoreboard.EventHandles.UpdatePlayerStat
  alias GoChampsScoreboard.Games.Models.GameState

  @initial_state %GameState{
    home_team: %{
      score: 1,
      players: [
        %{id: "123", stats_values: %{"points" => 1}}
      ],
      total_player_stats: %{"points" => 1}
    },
    away_team: %{
      score: 0,
      players: [
        %{id: "456", stats_values: %{}}
      ],
      total_player_stats: %{}
    }
  }

  test "increments player stats for home team" do
    payload = %{
      "operation" => "+",
      "team-type" => "home",
      "amount" => "2",
      "player-id" => "123",
      "stat-id" => "points"
    }

    expected_state = %GameState{
      home_team: %{
        score: 3,
        players: [
          %{id: "123", stats_values: %{"points" => 3}}
        ],
        total_player_stats: %{"points" => 3}
      },
      away_team: %{
        score: 0,
        players: [
          %{id: "456", stats_values: %{}}
        ],
        total_player_stats: %{}
      }
    }

    assert UpdatePlayerStat.handle(@initial_state, payload) == expected_state
  end

  test "decrements player stats for home team" do
    payload = %{
      "operation" => "-",
      "team-type" => "home",
      "amount" => "1",
      "player-id" => "123",
      "stat-id" => "points"
    }

    expected_state = %GameState{
      home_team: %{
        score: 0,
        players: [
          %{id: "123", stats_values: %{"points" => 0}}
        ],
        total_player_stats: %{"points" => 0}
      },
      away_team: %{
        score: 0,
        players: [%{id: "456", stats_values: %{}}],
        total_player_stats: %{}
      }
    }

    assert UpdatePlayerStat.handle(@initial_state, payload) == expected_state
  end

  test "increments player stats for away team" do
    payload = %{
      "operation" => "+",
      "team-type" => "away",
      "amount" => "1",
      "player-id" => "456",
      "stat-id" => "rebounds"
    }

    expected_state = %GameState{
      home_team: %{
        score: 1,
        players: [
          %{id: "123", stats_values: %{"points" => 1}}
        ],
        total_player_stats: %{"points" => 1}
      },
      away_team: %{
        score: 0,
        players: [
          %{id: "456", stats_values: %{"rebounds" => 1}}
        ],
        total_player_stats: %{"rebounds" => 1}
      }
    }

    assert UpdatePlayerStat.handle(@initial_state, payload) == expected_state
  end

  test "decrements player stats for away team" do
    initial_state = %GameState{
      home_team: %{
        score: 0,
        players: [],
        total_player_stats: %{}
      },
      away_team: %{
        score: 2,
        players: [
          %{id: "456", stats_values: %{"fouls" => 5}}
        ],
        total_player_stats: %{"fouls" => 5}
      }
    }

    payload = %{
      "operation" => "-",
      "team-type" => "away",
      "amount" => "1",
      "player-id" => "456",
      "stat-id" => "fouls"
    }

    expected_state = %GameState{
      home_team: %{
        score: 0,
        players: [],
        total_player_stats: %{}
      },
      away_team: %{
        score: 2,
        players: [
          %{id: "456", stats_values: %{"fouls" => 4}}
        ],
        total_player_stats: %{"fouls" => 4}
      }
    }

    assert UpdatePlayerStat.handle(initial_state, payload) == expected_state
  end
end
