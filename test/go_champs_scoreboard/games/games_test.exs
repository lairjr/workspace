defmodule GoChampsScoreboard.Games.GamesTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Models.TeamState
  alias GoChampsScoreboard.Games.Models.GameState

  import Mox

  setup :verify_on_exit!

  @http_client GoChampsScoreboard.HTTPClientMock

  describe "find_or_bootstrap/1 when game is set" do
    test "returns game_state" do
      set_test_game()

      result_game_state = Games.find_or_bootstrap("some-game-id")

      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Some away team"
      assert result_game_state.home_team.name == "Some home team"

      unset_test_game()
    end
  end

  describe "find_or_bootstrap/1 when game is not set" do
    test "bootstraps game and returns it" do
      response_body = %{
        "id" => "some-game-id",
        "away_team" => %{
          "name" => "Go champs away team",
        },
        "home_team" => %{
          "name" => "Go champs home team"
        }
      }
      expect(@http_client, :get, fn url ->
        assert url =~ "some-game-id"

        {:ok, %HTTPoison.Response{body: response_body |> Poison.encode!(), status_code: 200}}
      end)

      result_game_state = Games.find_or_bootstrap("some-game-id")

      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Go champs away team"
      assert result_game_state.home_team.name == "Go champs home team"
    end
  end

  defp set_test_game() do
    away_team = TeamState.new("Some away team")
    home_team = TeamState.new("Some home team")
    game_state = GameState.new("some-game-id", away_team, home_team)
    Redix.command(:games_cache, ["SET", "some-game-id", game_state])
  end

  defp unset_test_game() do
    Redix.command(:games_cache, ["DEL", "some-game-id"])
  end
end
