defmodule Games do
  def find(game_id) do
    case Redix.command(:games_cache, ["GET", game_id]) do
      {:ok, nil} ->
        default_game = %{
          id: game_id,
          away_team: %{ name: "Team A", score: 10 },
          home_team: %{ name: "Team B", score: 8 }
        }
        game_state = Poison.encode!(default_game)
        Redix.command(:games_cache, ["SET", game_id, game_state])
        default_game
      {:ok, curr_game} ->
        Poison.decode!(curr_game, as: %GoChampsScoreboard.GameState{away_team: %GoChampsScoreboard.TeamState{}, home_team: %GoChampsScoreboard.TeamState{}})
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
