defmodule GoChampsScoreboard.EventHandlers.UpdateTeamStat do
  alias GoChampsScoreboard.Sports.Sports
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Teams

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(
        current_game,
        %{
          "operation" => op,
          "stat-id" => stat_id,
          "team-type" => team_type
        }
      ) do
    team_stat =
      current_game.sport_id
      |> Sports.find_team_stat(stat_id)

    calculated_team_stats =
      current_game.sport_id
      |> Sports.find_calculated_team_stats()

    updated_team =
      current_game
      |> Teams.find_team(team_type)
      |> Teams.update_manual_stats_values(team_stat, op)
      |> Teams.update_calculated_stats_values(calculated_team_stats)

    current_game
    |> Games.update_team(team_type, updated_team)
  end
end
