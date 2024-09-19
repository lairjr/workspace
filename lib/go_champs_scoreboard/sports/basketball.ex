defmodule GoChampsScoreboard.Sports.Basketball do
  alias GoChampsScoreboard.Statistics.Models.PlayerStat

  @player_stats [
    PlayerStat.new("one-points-made", :manual, [:increment, :decrement]),
    PlayerStat.new("two-points-made", :manual, [:increment, :decrement]),
    PlayerStat.new("three-points-made", :manual, [:increment, :decrement]),
    PlayerStat.new("def-rebounds", :manual, [:increment, :decrement]),
    PlayerStat.new("off-rebounds", :manual, [:increment, :decrement]),
    PlayerStat.new("assists", :manual, [:increment, :decrement]),
    PlayerStat.new("blocks", :manual, [:increment, :decrement]),
    PlayerStat.new("tournovers", :manual, [:increment, :decrement]),
    PlayerStat.new("points", :calculated, [], 0, fn player_state ->
      player_state.stats_values["one-points-made"] * 1 +
        player_state.stats_values["two-points-made"] * 2 +
        player_state.stats_values["three-points-made"] * 3
    end),
    PlayerStat.new("rebounds", :calculated, [], 0, fn player_state ->
      player_state.stats_values["def-rebounds"] +
        player_state.stats_values["off-rebounds"]
    end)
  ]

  def bootstrap() do
    # Enum.reduce(@player_stats, %{}, fn stat, player_stats ->
    #   Map.merge(player_stats, %{[stat.key] => stat.value})
    # end)
  end
end
