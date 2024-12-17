defmodule GoChampsScoreboard.Sports.Basketball.Statistics do
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Games.Models.TeamState

  @spec calc_player_field_goal_percentage(PlayerState.t()) :: float()
  def calc_player_field_goal_percentage(player_state) do
    field_goals_made = Map.get(player_state.stats_values, "field_goals_made", 0)
    field_goals_missed = Map.get(player_state.stats_values, "field_goals_missed", 0)

    calc_percentage(field_goals_made, field_goals_missed)
  end

  @spec calc_player_field_goals_attempted(PlayerState.t()) :: float()
  def calc_player_field_goals_attempted(player_state) do
    field_goals_made = Map.get(player_state.stats_values, "field_goals_made", 0)
    field_goals_missed = Map.get(player_state.stats_values, "field_goals_missed", 0)

    field_goals_made + field_goals_missed
  end

  @spec calc_player_fouls(PlayerState.t()) :: float()
  def calc_player_fouls(player_state) do
    personal_fouls = Map.get(player_state.stats_values, "fouls_personal", 0)
    technical_fouls = Map.get(player_state.stats_values, "fouls_technical", 0)

    personal_fouls + technical_fouls
  end

  @spec calc_player_free_throw_percentage(PlayerState.t()) :: float()
  def calc_player_free_throw_percentage(player_state) do
    free_throws_made = Map.get(player_state.stats_values, "free_throws_made", 0)
    free_throws_missed = Map.get(player_state.stats_values, "free_throws_missed", 0)

    calc_percentage(free_throws_made, free_throws_missed)
  end

  @spec calc_player_free_throws_attempted(PlayerState.t()) :: float()
  def calc_player_free_throws_attempted(player_state) do
    free_throws_made = Map.get(player_state.stats_values, "free_throws_made", 0)
    free_throws_missed = Map.get(player_state.stats_values, "free_throws_missed", 0)

    free_throws_made + free_throws_missed
  end

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

  @spec calc_player_three_point_field_goal_percentage(PlayerState.t()) :: float()
  def calc_player_three_point_field_goal_percentage(player_state) do
    three_points_made = Map.get(player_state.stats_values, "three_point_field_goals_made", 0)
    three_points_missed = Map.get(player_state.stats_values, "three_point_field_goals_missed", 0)

    calc_percentage(three_points_made, three_points_missed)
  end

  @spec calc_player_three_point_field_goals_attempted(PlayerState.t()) :: float()
  def calc_player_three_point_field_goals_attempted(player_state) do
    three_points_made = Map.get(player_state.stats_values, "three_point_field_goals_made", 0)
    three_points_missed = Map.get(player_state.stats_values, "three_point_field_goals_missed", 0)

    three_points_made + three_points_missed
  end

  @spec calc_team_technical_fouls(TeamState.t()) :: float()
  def calc_team_technical_fouls(team_state) do
    total_technical_fouls_players = Map.get(team_state.total_player_stats, "fouls_technical", 0)
    technical_fouls = Map.get(team_state.stats_values, "fouls_technical", 0)

    total_technical_fouls_players + technical_fouls
  end

  defp calc_percentage(made, missed) do
    case made do
      0 -> 0
      _ -> (made / (made + missed) * 100) |> Float.round(3)
    end
  end
end
