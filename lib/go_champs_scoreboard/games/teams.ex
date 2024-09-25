defmodule GoChampsScoreboard.Games.Teams do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Games.Models.TeamState

  @spec find_player(GameState.t(), String.t(), String.t()) :: PlayerState.t()
  def find_player(game_state, team_type, player_id) do
    find_team(game_state, team_type)
      |> Map.get(:players)
      |> Enum.find(fn player -> player.id == player_id end)
  end

  @spec find_team(GameState.t(), String.t()) :: TeamState.t()
  def find_team(game_state, team_type) do
    case team_type do
      "home" -> game_state.home_team
      "away" -> game_state.away_team
      _ -> raise RuntimeError, message: "Invalid team type"
    end
  end
end
