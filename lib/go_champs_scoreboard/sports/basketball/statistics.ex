defmodule GoChampsScoreboard.Sports.Basketball.Statistics do
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Games.Models.TeamState

  @spec calc_player_points(PlayerState.t()) :: float()
  def calc_player_points(player_state) do
    one_points_made = Map.get(player_state.stats_values, "free_throws_made", 0)
    two_points_made = Map.get(player_state.stats_values, "field_goals_made", 0)
    three_points_made = Map.get(player_state.stats_values, "three_point_field_goals_made", 0)

    1 * one_points_made + 2 * two_points_made + 3 * three_points_made
  end

  @spec calc_player_rebounds(PlayerState.t()) :: float()
  def calc_player_rebounds(player_state) do
    def_rebounds = Map.get(player_state.stats_values, "rebounds_defensive", 0)
    off_rebounds = Map.get(player_state.stats_values, "rebounds_offensive", 0)

    def_rebounds + off_rebounds
  end

  @spec calc_player_fouls(PlayerState.t()) :: float()
  def calc_player_fouls(player_state) do
    personal_fouls = Map.get(player_state.stats_values, "fouls_personal", 0)
    technical_fouls = Map.get(player_state.stats_values, "fouls_technical", 0)

    personal_fouls + technical_fouls
  end

  @spec calc_team_technical_fouls(TeamState.t()) :: float()
  def calc_team_technical_fouls(team_state) do
    total_technical_fouls_players = Map.get(team_state.total_player_stats, "fouls_technical", 0)
    technical_fouls = Map.get(team_state.stats_values, "fouls_technical", 0)

    total_technical_fouls_players + technical_fouls
  end
end
