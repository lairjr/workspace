defmodule GoChampsScoreboard.EventHandles.AddPlayerToTeam do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Players
  alias GoChampsScoreboard.Games.Teams

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(game_state, %{"team_type" => team_type, "player" => player}) do
    player = Players.bootstrap(player["name"], player["number"])

    game_state
    |> Teams.add_player(team_type, player)
  end
end
