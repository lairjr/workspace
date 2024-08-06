defmodule GoChampsScoreboard.Games.Bootstrapper do
  alias GoChampsScoreboard.ApiClient
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.TeamState

  @spec bootstrap() :: GameState.t()
  def bootstrap() do
    home_team = TeamState.new("Home team", 0)
    away_team = TeamState.new("Away team", 0)
    game_id = randstring(16)

    GameState.new(game_id, away_team, home_team)
  end

  def bootstrap_from_go_champs(game, game_id) do
    {:ok, game_response} = ApiClient.get_game(game_id)

    game
    |> map_game_response_to_game(game_response)
  end

  @alphabet Enum.concat([?0..?9, ?A..?Z, ?a..?z])

  def randstring(count) do
    # Technically not needed, but just to illustrate we're
    # relying on the PRNG for this in random/1
    :rand.seed(:exsplus, :os.timestamp())
    Stream.repeatedly(&random_char_from_alphabet/0)
    |> Enum.take(count)
    |> List.to_string()
  end

  defp random_char_from_alphabet() do
    Enum.random(@alphabet)
  end

  defp map_game_response_to_game(game_state, game_response) do
    away_team_name = Map.get(game_response["away_team"], "name", game_state.away_team.name)
    home_team_name = Map.get(game_response["home_team"], "name", game_state.home_team.name)

    away_team = TeamState.new(away_team_name)
    home_team = TeamState.new(home_team_name)

    game_id = Map.get(game_response, "id", game_state.id)

    GameState.new(game_id, away_team, home_team)
  end
end
