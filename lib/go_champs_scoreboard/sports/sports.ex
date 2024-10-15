defmodule GoChampsScoreboard.Sports.Sports do
  alias GoChampsScoreboard.Sports.Basketball.Basketball
  alias GoChampsScoreboard.Statistics.Models.Stat

  @spec find_player_stat(String.t(), String.t()) :: Stat.t()
  def find_player_stat("basketball", stat_id), do: Basketball.find_player_stat(stat_id)

  @spec find_calculated_player_stats(String.t()) :: [Stat.t()]
  def find_calculated_player_stats("basketball"), do: Basketball.find_calculated_player_stats()

  @spec find_team_stat(String.t(), String.t()) :: Stat.t()
  def find_team_stat("basketball", stat_id), do: Basketball.find_team_stat(stat_id)

  @spec find_calculated_team_stats(String.t()) :: [Stat.t()]
  def find_calculated_team_stats("basketball"), do: Basketball.find_calculated_team_stats()
end
