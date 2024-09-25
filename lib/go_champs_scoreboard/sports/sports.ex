defmodule GoChampsScoreboard.Sports.Sports do
  alias GoChampsScoreboard.Sports.Basketball.Basketball
  alias GoChampsScoreboard.Statistics.Models.PlayerStat

  @spec find_player_stat(String.t(), String.t()) :: PlayerStat.t()
  def find_player_stat("basketball", stat_id), do: Basketball.find_player_stat(stat_id)

  @spec find_calculated_player_stats(String.t()) :: [PlayerStat.t()]
  def find_calculated_player_stats("basketball"), do: Basketball.find_calculated_player_stats()
end
