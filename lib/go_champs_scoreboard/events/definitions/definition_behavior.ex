defmodule GoChampsScoreboard.Events.Definitions.DefinitionBehavior do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Events.Models.Event

  @callback key() :: String.t()
  @callback validate_and_create(payload :: any()) :: {:ok, Event.t()} | {:error, any()}
  @callback handle(GameState.t(), Event.t()) :: GameState.t()
end
