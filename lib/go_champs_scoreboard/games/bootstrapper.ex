defmodule GoChampsScoreboard.Games.Bootstrapper do
  alias GoChampsScoreboard.Games.Models.LiveState
  alias GoChampsScoreboard.ApiClient
  alias GoChampsScoreboard.Games.Models.GameClockState
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Games.Models.TeamState

  @mock_initial_period_time 600

  @spec bootstrap() :: GameState.t()
  def bootstrap() do
    home_team = TeamState.new("Home team")
    away_team = TeamState.new("Away team")
    clock_state = GameClockState.new()
    game_id = Ecto.UUID.generate()
    live_state = LiveState.new()

    GameState.new(game_id, away_team, home_team, clock_state, live_state)
  end

  def bootstrap_from_go_champs(game, game_id, token) do
    {:ok, game_response} = ApiClient.get_game(game_id, token)

    game
    |> map_game_response_to_game(game_response)
  end

  defp map_game_response_to_game(game_state, game_data) do
    game_response = game_data["data"]
    away_team = map_api_team_to_team(game_response["away_team"])
    home_team = map_api_team_to_team(game_response["home_team"])

    game_id = Map.get(game_response, "id", game_state.id)

    clock_state = GameClockState.new(@mock_initial_period_time, @mock_initial_period_time)

    live_state = map_live_state(game_response["live_state"])

    GameState.new(game_id, away_team, home_team, clock_state, live_state)
  end

  defp map_api_team_to_team(team) do
    name = Map.get(team, "name", "No team")
    players = map_team_players_to_players(team)

    TeamState.new(name, players)
  end

  defp map_team_players_to_players(team) do
    team_players = Map.get(team, "players", [])

    Enum.map(Enum.with_index(team_players), fn {player, index} ->
      state = if index < 5, do: :playing, else: :available
      PlayerState.new(player["id"], player["name"], player["number"], state)
    end)
  end

  defp map_live_state(live_state) do
    case live_state do
      "not_started" -> LiveState.new(:not_started)
      "in_progress" -> LiveState.new(:in_progress)
      "ended" -> LiveState.new(:ended)
      _ -> LiveState.new(:not_started)
    end
  end
end
