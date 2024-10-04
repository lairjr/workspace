defmodule GoChampsScoreboard.EventHandles do
  alias GoChampsScoreboard.EventHandles.AddPlayerToTeam
  alias GoChampsScoreboard.EventHandles.RemovePlayerInTeam
  alias GoChampsScoreboard.EventHandles.UpdatePlayerStat
  alias GoChampsScoreboard.EventHandles.UpdatePlayerInTeam
  alias GoChampsScoreboard.EventHandles.UpdateTeamScore
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handler("add-player-to-team", game_state, payload),
    do: AddPlayerToTeam.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("remove-player-in-team", game_state, payload),
    do: RemovePlayerInTeam.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-player-in-team", game_state, payload),
    do: UpdatePlayerInTeam.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-player-stat", game_state, payload),
    do: UpdatePlayerStat.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-team-score", game_state, payload),
    do: UpdateTeamScore.handle(game_state, payload)
end
