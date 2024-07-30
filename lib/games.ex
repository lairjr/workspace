defmodule Games do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Bootstrapper

  @spec find(String.t()) :: GameState.t()
  def find(game_id) do
    case Redix.command(:games_cache, ["GET", game_id]) do
      {:ok, nil} ->
        game_state = Bootstrapper.bootstrap(game_id)
        Redix.command(:games_cache, ["SET", game_id, game_state])
        game_state
      {:ok, curr_game_json} ->
        GameState.from_json(curr_game_json)
    end
  end

  def topic(game_id) do
    "game-" <> game_id
  end

  def subscribe(game_id) do
    Phoenix.PubSub.subscribe(GoChampsScoreboard.PubSub, topic(game_id))
  end

  def inc_away(current_game_state) do
    new_game = %{ current_game_state | away_team: %{ current_game_state.away_team | score: current_game_state.away_team.score + 1 } }
    Redix.command(:games_cache, ["SET", new_game.id, Poison.encode!(new_game)])
    Phoenix.PubSub.broadcast(GoChampsScoreboard.PubSub, topic(current_game_state.id), {:update_game, new_game})
    {:ok, new_game}
  end

  def inc_home(current_game_state) do
    new_game = %{ current_game_state | home_team: %{ current_game_state.home_team | score: current_game_state.home_team.score + 1 } }
    Redix.command(:games_cache, ["SET", new_game.id, Poison.encode!(new_game)])
    Phoenix.PubSub.broadcast(GoChampsScoreboard.PubSub, topic(current_game_state.id), {:update_game, new_game})
    {:ok, new_game}
  end
end
