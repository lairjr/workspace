defmodule GoChampsScoreboard.EventHandlers.RemovePlayerInTeam do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Teams

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(game_state, %{"team-type" => team_type, "player-id" => player_id}) do
    game_state
    |> Teams.remove_player(team_type, player_id)
  end
end
