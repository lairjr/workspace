defmodule GoChampsScoreboard.Games.PlayersTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.Players
  alias GoChampsScoreboard.Statistics.Models.PlayerStat

  require IEx

  describe "update_manual_stats_values" do
    test "updates the player state with the new value" do
      player_state = %{
        stats_values: %{
          "one-points-made" => 1
        }
      }

      player_stat = PlayerStat.new("one-points-made", :manual, [:increment, :decrement])

      assert %{
               stats_values: %{
                 "one-points-made" => 2
               }
             } == Players.update_manual_stats_values(player_state, player_stat, "increment")
    end
  end

  describe "update_calculated_stats_values" do
    test "updates the player state with the new value" do
      player_state = %{
        stats_values: %{
          "two-points-made" => 5,
          "points" => 0
        }
      }

      player_stats = [
        PlayerStat.new(
          "points",
          :calculated,
          [],
          &GoChampsScoreboard.Sports.Basketball.Statistics.calc_player_points/1
        )
      ]

      assert %{
               stats_values: %{
                 "two-points-made" => 5,
                 "points" => 10
               }
             } == Players.update_calculated_stats_values(player_state, player_stats)
    end
  end
end
