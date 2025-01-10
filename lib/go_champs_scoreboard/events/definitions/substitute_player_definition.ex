defmodule GoChampsScoreboard.Events.Definitions.SubstitutePlayerDefinition do
  @behaviour GoChampsScoreboard.Events.Definitions.DefinitionBehavior

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.{Games, Teams, Players}
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @key "substitute-player"

  @impl true
  @spec key() :: String.t()
  def key, do: @key

  @impl true
  @spec validate(game_state :: GameState.t(), payload :: any()) ::
          {:ok} | {:error, any()}
  def validate(_game_state, _paylod), do: {:ok}

  @impl true
  @spec create(game_id :: String.t(), payload :: any()) :: Event.t()
  def create(game_id, payload), do: Event.new(@key, game_id, payload)

  @impl true
  @spec handle(GameState.t(), Event.t()) :: GameState.t()
  def handle(game_state, %Event{
        payload: %{
          "team-type" => team_type,
          "playing-player-id" => nil,
          "bench-player-id" => bench_player_id
        }
      }) do
    new_playing_player =
      game_state
      |> Teams.find_player(team_type, bench_player_id)
      |> Players.update_state(:playing)

    updated_team =
      game_state
      |> Teams.find_team(team_type)
      |> Teams.update_player_in_team(new_playing_player)

    game_state
    |> Games.update_team(team_type, updated_team)
  end

  @impl true
  @spec handle(GameState.t(), Event.t()) :: GameState.t()
  def handle(game_state, %Event{
        payload: %{
          "team-type" => team_type,
          "playing-player-id" => playing_player_id,
          "bench-player-id" => bench_player_id
        }
      }) do
    new_bench_player =
      game_state
      |> Teams.find_player(team_type, playing_player_id)
      |> Players.update_state(:bench)

    new_playing_player =
      game_state
      |> Teams.find_player(team_type, bench_player_id)
      |> Players.update_state(:playing)

    updated_team =
      game_state
      |> Teams.find_team(team_type)
      |> Teams.update_player_in_team(new_bench_player)
      |> Teams.update_player_in_team(new_playing_player)

    game_state
    |> Games.update_team(team_type, updated_team)
  end

  @impl true
  @spec stream_config() :: StreamConfig.t()
  def stream_config, do: StreamConfig.new()
end
