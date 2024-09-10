defmodule GoChampsScoreboard.EventHandles.UpdateTeamScore do
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(
        current_game,
        %{"operation" => op, "team-type" => team_type, "amount" => amount}
      ) do
    update_score(current_game, team_type, op, String.to_integer(amount))
  end

  defp update_score(current_game, "home", "+", amount) do
    update_home_score(current_game, amount)
  end

  defp update_score(current_game, "home", "-", amount) do
    update_home_score(current_game, -amount)
  end

  defp update_score(current_game, "away", "+", amount) do
    update_away_score(current_game, amount)
  end

  defp update_score(current_game, "away", "-", amount) do
    update_away_score(current_game, -amount)
  end

  defp update_score(_, _, _, _) do
    {:error, "Invalid operation or team type"}
  end

  defp update_home_score(current_game, amount) do
    %{
      current_game
      | home_team: %{current_game.home_team | score: current_game.home_team.score + amount}
    }
  end

  defp update_away_score(current_game, amount) do
    %{
      current_game
      | away_team: %{current_game.away_team | score: current_game.away_team.score + amount}
    }
  end
end
