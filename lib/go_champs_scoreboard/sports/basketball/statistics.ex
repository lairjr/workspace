defmodule GoChampsScoreboard.Sports.Basketball.Statistics do
  alias GoChampsScoreboard.Statistics.Models.PlayerStat

  @spec calc_player_points(PlayerState.t()) :: float()
  def calc_player_points(_player_state) do
    10
  end

  @spec calc_player_rebounds(PlayerState.t()) :: float()
  def calc_player_rebounds(_player_state) do
    0
  end
end
