defmodule GoChampsScoreboard.Events.Definitions.EndGameLiveModeDefinition do
  @behaviour GoChampsScoreboard.Events.Definitions.DefinitionBehavior

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @key "end-game-live-mode"

  @impl true
  @spec key() :: String.t()
  def key, do: @key

  @impl true
  @spec validate_and_create(payload :: any()) :: {:ok, Event.t()}
  def validate_and_create(_payload \\ nil) do
    {:ok, Event.new(@key)}
  end

  @impl true
  @spec handle(
          GameState.t(),
          Event.t()
        ) :: GameState.t()
  @spec handle(%{:live_state => any(), optional(any()) => any()}) :: %{
          :live_state => %{state: :ended},
          optional(any()) => any()
        }
  def handle(
        game_state,
        _event \\ nil
      ) do
    %{game_state | live_state: %{state: :ended}}
  end

  @impl true
  @spec stream_config() :: StreamConfig.t()
  def stream_config,
    do: StreamConfig.new(true, :generic_game_event_live_mode_builder)
end
