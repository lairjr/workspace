defmodule GoChampsScoreboard.EventHandles do
  alias GoChampsScoreboard.EventHandles.UpdatePlayerStat
  alias GoChampsScoreboard.EventHandles.UpdateTeamScore
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-team-score", game_state, payload),
    do: UpdateTeamScore.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-player-stat", game_state, payload),
    do: UpdatePlayerStat.handle(game_state, payload)
end
