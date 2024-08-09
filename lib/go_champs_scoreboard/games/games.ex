defmodule GoChampsScoreboard.Games.Games do
  alias GoChampsScoreboard.Games.Models.GameState
  
  @spec find_or_bootstrap(String.t()) :: GameState.t()
  def find_or_bootstrap(game_id) do
    case Redix.command(:games_cache, ["GET", game_id]) do
      {:ok, curr_game_json} ->
        GameState.from_json(curr_game_json)
    end
  end
end
