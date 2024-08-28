defmodule GoChampsScoreboard.Games.Games do
  alias GoChampsScoreboard.EventHandles
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Bootstrapper

  @spec find_or_bootstrap(String.t()) :: GameState.t()
  def find_or_bootstrap(game_id) do
    case Redix.command(:games_cache, ["GET", game_id]) do
      {:ok, nil} ->
        game_state =
          Bootstrapper.bootstrap()
          |> Bootstrapper.bootstrap_from_go_champs(game_id)

        Redix.command(:games_cache, ["SET", game_id, game_state])

        game_state

      {:ok, curr_game_json} ->
        GameState.from_json(curr_game_json)
    end
  end

  @spec topic(String.t()) :: String.t()
  def topic(game_id) do
    "game-" <> game_id
  end

  @spec subscribe(String.t()) :: :ok | {:error, {:already_registered, pid()}}
  def subscribe(game_id) do
    Phoenix.PubSub.subscribe(GoChampsScoreboard.PubSub, topic(game_id))
  end

  @spec handle_event(String.t(), String.t(), any()) :: GameState.t()
  def handle_event(game_id, event, event_payload) do
    current_game_state = find_or_bootstrap(game_id)
    new_game_state = EventHandles.handle(event, current_game_state, event_payload)
    Redix.command(:games_cache, ["SET", game_id, new_game_state])

    Phoenix.PubSub.broadcast(
      GoChampsScoreboard.PubSub,
      topic(game_id),
      {:update_game, new_game_state}
    )

    new_game_state
  end
end
