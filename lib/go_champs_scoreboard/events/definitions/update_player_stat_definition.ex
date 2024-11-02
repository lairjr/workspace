defmodule GoChampsScoreboard.Events.Definitions.UpdatePlayerStatDefinition do
  @behaviour GoChampsScoreboard.Events.Definitions.Definition

  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Sports.Sports
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Teams
  alias GoChampsScoreboard.Games.Players

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(
        current_game,
        %{
          "operation" => op,
          "stat-id" => stat_id,
          "player-id" => player_id,
          "team-type" => team_type
        }
      ) do
    player_stat =
      current_game.sport_id
      |> Sports.find_player_stat(stat_id)

    calculated_player_stats =
      current_game.sport_id
      |> Sports.find_calculated_player_stats()

    updated_player =
      current_game
      |> Teams.find_player(team_type, player_id)
      |> Players.update_manual_stats_values(player_stat, op)
      |> Players.update_calculated_stats_values(calculated_player_stats)

    updated_team =
      current_game
      |> Teams.find_team(team_type)
      |> Teams.update_player_in_team(updated_player)
      |> Teams.calculate_team_total_player_stats()

    current_game
    |> Games.update_team(team_type, updated_team)
  end
end
