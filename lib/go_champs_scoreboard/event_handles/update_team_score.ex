defmodule GoChampsScoreboard.EventHandles.UpdateTeamScore do
  alias GoChampsScoreboard.Games.Models.GameState
  require Logger

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(current_game, payload) do
    Logger.info("Handle event")
    Logger.info(payload)

    %{
      current_game
      | away_team: %{current_game.away_team | score: current_game.away_team.score + 1}
    }
  end
end
