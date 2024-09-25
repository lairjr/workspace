defmodule GoChampsScoreboard.Sports.Basketball.BasketballTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Sports.Basketball.Basketball

  describe "bootstrap" do
    test "returns a map with all player stats" do
      expected = %{
        "one-points-made" => 0,
        "two-points-made" => 0,
        "three-points-made" => 0,
        "def-rebounds" => 0,
        "off-rebounds" => 0,
        "assists" => 0,
        "blocks" => 0,
        "tournovers" => 0,
        "points" => 0,
        "rebounds" => 0
      }

      assert expected == Basketball.bootstrap()
    end
  end

  describe "find_player_stat" do
    test "returns the player stat with the given key" do
      assert %GoChampsScoreboard.Statistics.Models.PlayerStat{
               key: "points",
               type: :calculated,
               operations: [],
               calculation_function:
                 &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_points/1
             } == Basketball.find_player_stat("points")
    end

    test "returns nil if the player stat with the given key is not found" do
      assert nil == Basketball.find_player_stat("non-existing-stat")
    end
  end

  describe "find_calculated_player_stats" do
    test "returns all calculated player stats" do
      expected = [
        %GoChampsScoreboard.Statistics.Models.PlayerStat{
          key: "points",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_points/1
        },
        %GoChampsScoreboard.Statistics.Models.PlayerStat{
          key: "rebounds",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_rebounds/1
        }
      ]

      assert expected == Basketball.find_calculated_player_stats()
    end
  end
end
