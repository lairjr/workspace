defmodule GoChampsScoreboard.Sports.Basketball.Statistics do
  alias GoChampsScoreboard.Games.Models.PlayerState

  @spec calc_player_points(PlayerState.t()) :: float()
  def calc_player_points(player_state) do
    one_points_made = Map.get(player_state.stats_values, "one-points-made", 0)
    two_points_made = Map.get(player_state.stats_values, "two-points-made", 0)
    three_points_made = Map.get(player_state.stats_values, "three-points-made", 0)

    1 * one_points_made + 2 * two_points_made + 3 * three_points_made
  end

  @spec calc_player_rebounds(PlayerState.t()) :: float()
  def calc_player_rebounds(player_state) do
    def_rebounds = Map.get(player_state.stats_values, "def-rebounds", 0)
    off_rebounds = Map.get(player_state.stats_values, "off-rebounds", 0)

    def_rebounds + off_rebounds
  end
end
