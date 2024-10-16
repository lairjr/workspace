defmodule GoChampsScoreboard.EventHandlers do
  alias GoChampsScoreboard.EventHandlers.GameTick
  alias GoChampsScoreboard.EventHandlers.AddPlayerToTeam
  alias GoChampsScoreboard.EventHandlers.RemovePlayerInTeam
  alias GoChampsScoreboard.EventHandlers.UpdateClockState
  alias GoChampsScoreboard.EventHandlers.UpdatePlayerStat
  alias GoChampsScoreboard.EventHandlers.UpdatePlayerInTeam
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("add-player-to-team", game_state, payload),
    do: AddPlayerToTeam.handle(game_state, payload)

  def handle("clock-tick", game_state, _payload), do: GameTick.handle(game_state)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("remove-player-in-team", game_state, payload),
    do: RemovePlayerInTeam.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-clock-state", game_state, payload),
    do: UpdateClockState.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-player-in-team", game_state, payload),
    do: UpdatePlayerInTeam.handle(game_state, payload)

  @spec handle(String.t(), GameState.t(), any()) :: GameState.t()
  def handle("update-player-stat", game_state, payload),
    do: UpdatePlayerStat.handle(game_state, payload)
end
