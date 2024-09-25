defmodule GoChampsScoreboard.Sports.Basketball.StatisticsTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Sports.Basketball.Statistics

  describe "calc_player_points" do
    test "returns the sum of (1 * one-points-made), (2 * two-points-made), and (3 * three-points-made)" do
      player_state = %GoChampsScoreboard.Games.Models.PlayerState{
        stats_values: %{
          "one-points-made" => 1,
          "two-points-made" => 2,
          "three-points-made" => 3
        }
      }

      assert Statistics.calc_player_points(player_state) == 14
    end
  end

  describe "calc_player_rebounds" do
    test "returns them sum of off-rebounds and def-rebounds" do
      player_state = %GoChampsScoreboard.Games.Models.PlayerState{
        stats_values: %{
          "def-rebounds" => 2,
          "off-rebounds" => 1
        }
      }

      assert Statistics.calc_player_rebounds(player_state) == 3
    end
  end
end
