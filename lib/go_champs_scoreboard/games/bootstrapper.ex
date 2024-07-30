defmodule GoChampsScoreboard.Games.Bootstrapper do
  alias GoChampsScoreboard.Games.Models.GameState

  @spec bootstrap(String.t()) :: GoChampsScoreboard.GameState.t()
  @spec bootstrap() :: GoChampsScoreboard.GameState.t()
  def bootstrap(game_id \\ "game-id") do
    home_team = GoChampsScoreboard.Games.Models.TeamState.new("Home team", 0)
    away_team = GoChampsScoreboard.Games.Models.TeamState.new("Away team", 0)

    GameState.new(game_id, away_team, home_team)
  end
end
