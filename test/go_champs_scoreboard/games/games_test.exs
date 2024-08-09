defmodule GoChampsScoreboard.Games.GamesTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Models.TeamState
  alias GoChampsScoreboard.Games.Models.GameState

  describe "find_or_bootstrap/1 when game is database" do
    setup :set_test_game

    test "returns game_state" do
      result_game_state = Games.find_or_bootstrap("some-game-id")

      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Some away team"
      assert result_game_state.home_team.name == "Some home team"
    end
  end

  defp set_test_game(_context) do
    away_team = TeamState.new("Some away team")
    home_team = TeamState.new("Some home team")
    game_state = GameState.new("some-game-id", away_team, home_team)
    Redix.command(:games_cache, ["SET", "some-game-id", game_state])
    :ok
  end
end
