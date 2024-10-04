defmodule GoChampsScoreboard.Games.PlayersTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.Players
  alias GoChampsScoreboard.Statistics.Models.PlayerStat

  describe "bootstrap" do
    test "returns a new player state with new random id, given name and number" do
      player_state = Players.bootstrap("Michael Jordan", 23)

      assert is_bitstring(player_state.id)
      assert "Michael Jordan" == player_state.name
      assert 23 == player_state.number
    end
  end

  describe "update_manual_stats_values" do
    test "updates the player state with the new value" do
      player_state = %{
        stats_values: %{
          "one-points-made" => 1
        }
      }

      player_stat = PlayerStat.new("one-points-made", :manual, [:increment])

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
          "def-rebounds" => 2,
          "points" => 0,
          "rebounds" => 0
        }
      }

      player_stats = [
        PlayerStat.new(
          "points",
          :calculated,
          [],
          fn player_state -> player_state.stats_values["two-points-made"] * 2 end
        ),
        PlayerStat.new(
          "rebounds",
          :calculated,
          [],
          fn player_state -> player_state.stats_values["def-rebounds"] + 1 end
        )
      ]

      assert %{
               stats_values: %{
                 "two-points-made" => 5,
                 "def-rebounds" => 2,
                 "points" => 10,
                 "rebounds" => 3
               }
             } == Players.update_calculated_stats_values(player_state, player_stats)
    end
  end
end
