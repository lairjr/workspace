defmodule GoChampsScoreboard.Events.Handler do
  alias GoChampsScoreboard.Events.Definitions.Registry
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(GameState.t(), Event.t()) :: GameState.t()
  def handle(game_state, %Event{key: key} = event) do
    case Registry.get_definition(key) do
      {:ok, definition} ->
        definition.handle(game_state, event)

      {:error, :not_registered} ->
        game_state
    end
  end
end
