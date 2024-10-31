defmodule GoChampsScoreboard.Games.Messages.PubSub do
  alias GoChampsScoreboard.Games.Models.GameState

  @spec subscribe(String.t()) :: :ok | {:error, {:already_registered, pid()}}
  def subscribe(game_id, pub_sub \\ GoChampsScoreboard.PubSub) do
    Phoenix.PubSub.subscribe(pub_sub, topic(game_id))
  end

  @spec topic(String.t()) :: String.t()
  def topic(game_id) do
    "game-" <> game_id
  end

  @spec broadcast_game_update(String.t(), GameState.t()) :: :ok
  def broadcast_game_update(game_id, game_state, pub_sub \\ GoChampsScoreboard.PubSub) do
    Phoenix.PubSub.broadcast(
      pub_sub,
      topic(game_id),
      {:update_game, game_state}
    )
  end

  @spec broadcast_game_update(String.t(), GameState.t()) :: :ok
  def broadcast_game_reacted_to_event(event, game_state, pub_sub \\ GoChampsScoreboard.PubSub) do
    Phoenix.PubSub.broadcast(
      pub_sub,
      topic(game_state.id),
      {:game_reacted_to_event, %{event: event, game_state: game_state}}
    )
  end
end
