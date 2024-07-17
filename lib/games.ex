defmodule Games do
  def find(game_id) do
    %{
      id: "game-id",
      away_team: %{ name: "Team A", score: 10 },
      home_team: %{ name: "Team B", score: 8 }
    }
  end

  def topic(game_id) do
    "game-" <> game_id
  end

  def subscribe(game_id) do
    Phoenix.PubSub.subscribe(GoChampsScoreboard.PubSub, topic(game_id))
  end

  def inc_away(current_game_state) do
    new_game = %{ current_game_state | away_team: %{ current_game_state.away_team | score: current_game_state.away_team.score + 1 } }
    Phoenix.PubSub.broadcast(GoChampsScoreboard.PubSub, topic(current_game_state.id), {:update_game, new_game})
    {:ok, new_game}
  end

  def inc_home(current_game_state) do
    new_game = %{ current_game_state | home_team: %{ current_game_state.home_team | score: current_game_state.home_team.score + 1 } }
    Phoenix.PubSub.broadcast(GoChampsScoreboard.PubSub, topic(current_game_state.id), {:update_game, new_game})
    {:ok, new_game}
  end
end
