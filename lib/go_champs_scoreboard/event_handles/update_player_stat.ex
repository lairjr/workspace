defmodule GoChampsScoreboard.EventHandles.UpdatePlayerStat do
  alias GoChampsScoreboard.Games.Models.GameState
  require Logger

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(
        current_game,
        %{
          "operation" => op,
          "amount" => amount,
          "stat-id" => stat_id,
          "player-id" => player_id,
          "team-type" => team_type
        }
      ) do
    update_game(current_game, team_type, op, String.to_integer(amount), player_id, stat_id)
  end

  defp update_game(current_game, "home", op, amount, player_id, stats_id) do
    updated_team = update_team(current_game.home_team, op, amount, player_id, stats_id)
    %{current_game | home_team: updated_team}
  end

  defp update_game(current_game, "away", op, amount, player_id, stats_id) do
    updated_team = update_team(current_game.away_team, op, amount, player_id, stats_id)
    %{current_game | away_team: updated_team}
  end

  defp update_team(team, op, amount, player_id, stats_id) do
    updated_players =
      Enum.map(team.players, fn player ->
        if player.id == player_id do
          updated_player_stats = update_player_stats(player.stats_values, stats_id, op, amount)
          %{player | stats_values: updated_player_stats}
        else
          player
        end
      end)

    updated_team_stats = sum_stats_values(updated_players)

    %{
      team
      | players: updated_players,
        total_player_stats: updated_team_stats
    }
  end

  defp update_player_stats(stats_values, stats_id, "+", amount) do
    Map.update(stats_values, stats_id, amount, &(&1 + amount))
  end

  defp update_player_stats(stats_values, stats_id, "-", amount) do
    Map.update(stats_values, stats_id, 0, &(&1 - amount))
  end

  defp sum_stats_values(players) do
    Enum.reduce(players, %{}, fn player, acc ->
      player
      |> Map.get(:stats_values, %{})
      |> Enum.reduce(acc, fn {key, value}, acc ->
        Map.update(acc, key, value, &(&1 + value))
      end)
    end)
  end
end
