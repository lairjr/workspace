defmodule GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition do
  @behaviour GoChampsScoreboard.Events.Definitions.DefinitionBehavior

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @key "start-game-live-mode"

  @impl true
  @spec key() :: String.t()
  def key, do: @key

  @impl true
  @spec validate_and_create(payload :: any()) :: {:ok, Event.t()}
  def validate_and_create(_payload \\ nil), do: {:ok, Event.new(@key)}

  @impl true
  @spec handle(game_state :: GameState.t(), event :: Event.t()) :: GameState.t()
  def handle(
        game_state,
        _event \\ nil
      ) do
    %{game_state | live_state: %{state: :running}}
  end

  @impl true
  @spec stream_config() :: StreamConfig.t()
  def stream_config do
    StreamConfig.new(true, :generic_game_event_live_mode_builder)
  end
end
