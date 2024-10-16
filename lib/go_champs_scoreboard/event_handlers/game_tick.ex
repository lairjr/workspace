defmodule GoChampsScoreboard.EventHandlers.GameTick do
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(GameState.t()) :: GameState.t()
  def handle(game_state) do
    current_time = System.system_time(:second)

    game_state
  end
end
