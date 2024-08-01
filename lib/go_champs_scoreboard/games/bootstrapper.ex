defmodule GoChampsScoreboard.Games.Bootstrapper do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.TeamState

  @spec bootstrap() :: GameState.t()
  def bootstrap() do
    home_team = TeamState.new("Home team", 0)
    away_team = TeamState.new("Away team", 0)
    game_id = randstring(16)

    GameState.new(game_id, away_team, home_team)
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
end
