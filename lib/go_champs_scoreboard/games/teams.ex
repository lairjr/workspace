defmodule GoChampsScoreboard.Games.Teams do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Games.Models.TeamState

  @spec add_player(GameState.t(), String.t(), PlayerState.t()) :: GameState.t()
  def add_player(game_state, team_type, player) do
    case team_type do
      "home" ->
        game_state
        |> Map.update!(:home_team, fn team -> add_player_to_team(team, player) end)

      "away" ->
        game_state
        |> Map.update!(:away_team, fn team -> add_player_to_team(team, player) end)

      _ ->
        raise RuntimeError, message: "Invalid team type"
    end
  end

  @spec add_player_to_team(TeamState.t(), PlayerState.t()) :: TeamState.t()
  def add_player_to_team(team, player) do
    team
    |> Map.update!(:players, fn players -> [player | players] end)
  end

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

  @spec list_players(GameState.t(), String.t()) :: [PlayerState.t()]
  def list_players(game_state, team_type) do
    find_team(game_state, team_type).players
  end

  @spec update_player(GameState.t(), String.t(), PlayerState.t()) :: GameState.t()
  def update_player(game_state, team_type, player) do
    case team_type do
      "home" ->
        game_state
        |> Map.update!(:home_team, fn team -> update_player_in_team(team, player) end)

      "away" ->
        game_state
        |> Map.update!(:away_team, fn team -> update_player_in_team(team, player) end)

      _ ->
        raise RuntimeError, message: "Invalid team type"
    end
  end

  @spec update_player_in_team(TeamState.t(), PlayerState.t()) :: TeamState.t()
  def update_player_in_team(team, player) do
    team
    |> Map.update!(:players, fn players ->
      Enum.map(players, fn p -> if p.id == player.id, do: player, else: p end)
    end)
  end

  @spec remove_player(GameState.t(), String.t(), String.t()) :: GameState.t()
  def remove_player(game_state, team_type, player_id) do
    case team_type do
      "home" ->
        game_state
        |> Map.update!(:home_team, fn team -> remove_player_in_team(team, player_id) end)

      "away" ->
        game_state
        |> Map.update!(:away_team, fn team -> remove_player_in_team(team, player_id) end)

      _ ->
        raise RuntimeError, message: "Invalid team type"
    end
  end

  @spec remove_player_in_team(TeamState.t(), String.t()) :: TeamState.t()
  def remove_player_in_team(team, player_id) do
    team
    |> Map.update!(:players, fn players ->
      Enum.reject(players, fn player -> player.id == player_id end)
    end)
  end
end
