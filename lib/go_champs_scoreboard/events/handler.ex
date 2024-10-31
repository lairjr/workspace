defmodule GoChampsScoreboard.Events.Handler do
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState

  alias GoChampsScoreboard.Events.Definitions.GameTickDefinition

  @spec handle(GameState.t(), Event.t()) :: GameState.t()
  def handle(game_state, %Event{key: key} = _event) do
    case key do
      "game-tick" -> GameTickDefinition.handle(game_state)
      _ -> game_state
    end
  end
end
