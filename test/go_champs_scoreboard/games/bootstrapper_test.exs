defmodule GoChampsScoreboard.Games.BootstrapperTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.Bootstrapper

  import Mox

  describe "bootstrap" do
    test "bootstraps with random game-id" do
      game = Bootstrapper.bootstrap()
      assert String.length(game.id) > 0
    end

    test "bootstraps with home team and away team" do
      game = Bootstrapper.bootstrap()
      assert game.away_team.name == "Away team"
      assert game.away_team.players == []
      assert game.away_team.total_player_stats == %{}
      assert game.home_team.name == "Home team"
      assert game.home_team.players == []
      assert game.home_team.total_player_stats == %{}
    end
  end

  describe "bootstrap_from_api" do
    @http_client GoChampsScoreboard.HTTPClientMock
    @response_body %{
      "data" => %{
        "id" => "game-id",
        "away_team" => %{
          "name" => "Team A"
        },
        "home_team" => %{
          "name" => "Team B"
        }
      }
    }

    test "maps game id" do
      expect(@http_client, :get, fn url ->
        assert url =~ "game-id"

        {:ok, %HTTPoison.Response{body: @response_body |> Poison.encode!(), status_code: 200}}
      end)

      game =
        Bootstrapper.bootstrap_from_go_champs(
          GoChampsScoreboard.Games.Bootstrapper.bootstrap(),
          "game-id"
        )

      assert game.id == "game-id"
      assert game.away_team.name == "Team A"
      assert Enum.count(game.away_team.players) == 2
      assert game.away_team.total_player_stats == %{}
      assert game.home_team.name == "Team B"
      assert Enum.count(game.home_team.players) == 2
      assert game.home_team.total_player_stats == %{}
    end
  end
end
