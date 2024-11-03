defmodule GoChampsScoreboard.Events.Definitions.UpdateClockStateDefinition do
  @behaviour GoChampsScoreboard.Events.Definitions.DefinitionBehavior

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @key "update-clock-state"

  @impl true
  @spec key() :: String.t()
  def key, do: @key

  @impl true
  @spec validate_and_create(payload :: any()) :: {:ok, Event.t()}
  def validate_and_create(payload) do
    {:ok, Event.new(@key, payload)}
  end

  @impl true
  @spec handle(GameState.t(), Event.t()) :: GameState.t()
  def handle(game_state, %Event{payload: %{"state" => state}}) do
    new_clock_state = %{game_state.clock_state | state: String.to_atom(state)}

    game_state
    |> Games.update_clock_state(new_clock_state)
  end

  @impl true
  @spec stream_config() :: StreamConfig.t()
  def stream_config, do: StreamConfig.new()
end
