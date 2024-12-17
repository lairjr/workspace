defmodule GoChampsScoreboard.Sports.Basketball.BasketballTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Sports.Basketball.Basketball

  describe "bootstrap" do
    test "returns a map with all player stats" do
      expected = %{
        "assists" => 0,
        "blocks" => 0,
        "disqualifications" => 0,
        "ejections" => 0,
        "efficiency" => 0,
        "field_goal_percentage" => 0,
        "field_goals_attempted" => 0,
        "field_goals_missed" => 0,
        "field_goals_made" => 0,
        "fouls" => 0,
        "fouls_flagrant" => 0,
        "fouls_personal" => 0,
        "fouls_technical" => 0,
        "free_throw_percentage" => 0,
        "free_throws_attempted" => 0,
        "free_throws_missed" => 0,
        "free_throws_made" => 0,
        "game_played" => 0,
        "game_started" => 0,
        "minutes_played" => 0,
        "plus_minus" => 0,
        "points" => 0,
        "rebounds" => 0,
        "rebounds_defensive" => 0,
        "rebounds_offensive" => 0,
        "steals" => 0,
        "three_point_field_goal_percentage" => 0,
        "three_point_field_goals_attempted" => 0,
        "three_point_field_goals_missed" => 0,
        "three_point_field_goals_made" => 0,
        "turnovers" => 0
      }

      assert expected == Basketball.bootstrap()
    end
  end

  describe "find_player_stat" do
    test "returns the player stat with the given key" do
      assert %GoChampsScoreboard.Statistics.Models.Stat{
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
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "field_goal_percentage",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_field_goal_percentage/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "field_goals_attempted",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_field_goals_attempted/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_fouls/1,
          key: "fouls",
          operations: [],
          type: :calculated
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "free_throw_percentage",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_free_throw_percentage/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "free_throws_attempted",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_free_throws_attempted/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "points",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_points/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "rebounds",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_rebounds/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "three_point_field_goal_percentage",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_three_point_field_goal_percentage/1
        },
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "three_point_field_goals_attempted",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_three_point_field_goals_attempted/1
        }
      ]

      assert expected == Basketball.find_calculated_player_stats()
    end
  end

  describe "bootstrap_team_stats" do
    test "returns a map with all team stats" do
      expected = %{
        "timeouts" => 0,
        "fouls_technical" => 0,
        "total_fouls_technical" => 0
      }

      assert expected == Basketball.bootstrap_team_stats()
    end
  end

  describe "find_calculated_team_stats" do
    test "returns all calculated team stats" do
      expected = [
        %GoChampsScoreboard.Statistics.Models.Stat{
          key: "total_fouls_technical",
          type: :calculated,
          operations: [],
          calculation_function:
            &GoChampsScoreboard.Sports.Basketball.Statistics.calc_team_technical_fouls/1
        }
      ]

      assert expected == Basketball.find_calculated_team_stats()
    end
  end

  describe "find_team_stat" do
    test "returns the team stat with the given key" do
      assert %GoChampsScoreboard.Statistics.Models.Stat{
               key: "fouls_technical",
               type: :manual,
               operations: [:increment, :decrement],
               calculation_function: nil
             } == Basketball.find_player_stat("fouls_technical")
    end

    test "returns nil if the team stat with the given key is not found" do
      assert nil == Basketball.find_team_stat("non-existing-stat")
    end
  end
end
