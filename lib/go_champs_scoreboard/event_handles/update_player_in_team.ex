defmodule GoChampsScoreboard.EventHandles.UpdatePlayerInTeam do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Teams

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(game_state, %{"team_type" => team_type, "player" => player}) do
    player = Map.new(player, fn {k, v} -> {String.to_atom(k), v} end)

    current_player =
      game_state
      |> Teams.find_player(team_type, player.id)

    updated_player = Map.merge(current_player, player)

    game_state
    |> Teams.update_player(team_type, updated_player)
  end
end
