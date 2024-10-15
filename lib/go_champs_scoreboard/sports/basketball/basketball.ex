defmodule GoChampsScoreboard.Sports.Basketball.Basketball do
  alias GoChampsScoreboard.Sports.Basketball.Statistics
  alias GoChampsScoreboard.Statistics.Models.Stat

  @player_stats [
    Stat.new("two-points-made", :manual, [:increment, :decrement]),
    Stat.new("one-points-made", :manual, [:increment, :decrement]),
    Stat.new("three-points-made", :manual, [:increment, :decrement]),
    Stat.new("def-rebounds", :manual, [:increment, :decrement]),
    Stat.new("off-rebounds", :manual, [:increment, :decrement]),
    Stat.new("assists", :manual, [:increment, :decrement]),
    Stat.new("blocks", :manual, [:increment, :decrement]),
    Stat.new("tournovers", :manual, [:increment, :decrement]),
    Stat.new("steals", :manual, [:increment, :decrement]),
    Stat.new("personal-fouls", :manual, [:increment, :decrement]),
    Stat.new("technical-fouls", :manual, [:increment, :decrement]),
    Stat.new("points", :calculated, [], &Statistics.calc_player_points/1),
    Stat.new("rebounds", :calculated, [], &Statistics.calc_player_rebounds/1),
    Stat.new("fouls", :calculated, [], &Statistics.calc_player_fouls/1)
  ]

  @team_stats [
    Stat.new("technical-fouls", :manual, [:increment, :decrement]),
    Stat.new("total-technical-fouls", :calculated, [], &Statistics.calc_team_technical_fouls/1)
  ]

  @spec bootstrap() :: %{String.t() => number()}
  def bootstrap() do
    Enum.reduce(@player_stats, %{}, fn stat, player_stats ->
      Map.merge(player_stats, %{stat.key => 0})
    end)
  end

  @spec bootstrap_team_stats() :: %{String.t() => number()}
  def bootstrap_team_stats() do
    Enum.reduce(@team_stats, %{}, fn stat, team_stats ->
      Map.merge(team_stats, %{stat.key => 0})
    end)
  end

  @spec find_player_stat(String.t()) :: Stat.t()
  def find_player_stat(stat_id) do
    Enum.find(@player_stats, fn stat -> stat.key == stat_id end)
  end

  @spec find_calculated_player_stats() :: [Stat.t()]
  def find_calculated_player_stats() do
    Enum.filter(@player_stats, fn stat -> stat.type == :calculated end)
  end
end
