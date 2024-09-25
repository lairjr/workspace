defmodule GoChampsScoreboard.Sports.Basketball.Basketball do
  alias GoChampsScoreboard.Sports.Basketball.Statistics
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
    PlayerStat.new("points", :calculated, [], &Statistics.calc_player_points/1),
    PlayerStat.new("rebounds", :calculated, [], &Statistics.calc_player_rebounds/1)
  ]

  def bootstrap() do
    Enum.reduce(@player_stats, %{}, fn stat, player_stats ->
      Map.merge(player_stats, %{stat.key => 0})
    end)
  end

  @spec find_player_stat(String.t()) :: PlayerStat.t()
  def find_player_stat(stat_id) do
    Enum.find(@player_stats, fn stat -> stat.key == stat_id end)
  end

  @spec find_calculated_player_stats() :: [PlayerStat.t()]
  def find_calculated_player_stats() do
    Enum.filter(@player_stats, fn stat -> stat.type == :calculated end)
  end
end
