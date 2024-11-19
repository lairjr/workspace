defmodule GoChampsScoreboard.Sports.Basketball.StatisticsTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Sports.Basketball.Statistics

  describe "calc_player_points" do
    test "returns the sum of (1 * one-points-made), (2 * field_goals_made), and (3 * three-points-made)" do
      player_state = %GoChampsScoreboard.Games.Models.PlayerState{
        stats_values: %{
          "free_throws_made" => 1,
          "field_goals_made" => 2,
          "three_point_field_goals_made" => 3
        }
      }

      assert Statistics.calc_player_points(player_state) == 14
    end
  end

  describe "calc_player_rebounds" do
    test "returns them sum of off-rebounds and def-rebounds" do
      player_state = %GoChampsScoreboard.Games.Models.PlayerState{
        stats_values: %{
          "rebounds_defensive" => 2,
          "rebounds_offensive" => 1
        }
      }

      assert Statistics.calc_player_rebounds(player_state) == 3
    end
  end

  describe "calc_player_fouls" do
    test "returns them sum of personal-fouls and technical-fouls" do
      player_state = %GoChampsScoreboard.Games.Models.PlayerState{
        stats_values: %{
          "fouls_personal" => 3,
          "fouls_technical" => 1
        }
      }

      assert Statistics.calc_player_fouls(player_state) == 4
    end
  end

  describe "calc_team_technical_fouls" do
    test "returns them sum of personal-fouls and technical-fouls" do
      team_state = %GoChampsScoreboard.Games.Models.TeamState{
        total_player_stats: %{
          "fouls_technical" => 1
        },
        stats_values: %{
          "fouls_technical" => 1
        }
      }

      assert Statistics.calc_team_technical_fouls(team_state) == 2
    end
  end
end
