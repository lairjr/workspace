defmodule GoChampsScoreboard.EventHandlers.UpdatePlayerInTeam do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Teams

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(game_state, %{"team_type" => team_type, "player" => player}) do
    player = Map.new(player, fn {k, v} -> {String.to_atom(k), v} end)

    current_player =
      game_state
      |> Teams.find_player(team_type, player.id)

    updated_player = Map.merge(current_player, player)

    updated_team =
      game_state
      |> Teams.find_team(team_type)
      |> Teams.update_player_in_team(updated_player)

    game_state
    |> Games.update_team(team_type, updated_team)
  end
end
