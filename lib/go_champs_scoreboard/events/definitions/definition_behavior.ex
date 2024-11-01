defmodule GoChampsScoreboard.Events.Definitions.DefinitionBehavior do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @callback key() :: String.t()
  @callback validate_and_create(payload :: any()) :: {:ok, Event.t()} | {:error, any()}
  @callback handle(GameState.t(), Event.t()) :: GameState.t()
  @callback stream_config() :: StreamConfig.t()

  @optional_callbacks stream_config: 0
end
