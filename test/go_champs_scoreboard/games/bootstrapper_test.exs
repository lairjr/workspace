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
          "name" => "Team A",
          "players" => [
            %{
              "id" => "player-1",
              "name" => "Player 1",
              "number" => 1
            },
            %{
              "id" => "player-2",
              "name" => "Player 2"
            }
          ]
        },
        "home_team" => %{
          "name" => "Team B",
          "players" => [
            %{
              "id" => "player-3",
              "name" => "Player 3",
              "number" => 3
            },
            %{
              "id" => "player-4",
              "name" => "Player 4"
            }
          ]
        }
      }
    }

    test "maps game id" do
      expect(@http_client, :get, fn url, headers ->
        assert url =~ "game-id"
        assert headers == [{"Authorization", "Bearer token"}]

        {:ok, %HTTPoison.Response{body: @response_body |> Poison.encode!(), status_code: 200}}
      end)

      game =
        Bootstrapper.bootstrap_from_go_champs(
          GoChampsScoreboard.Games.Bootstrapper.bootstrap(),
          "game-id",
          "token"
        )

      [player_1, player_2] = game.away_team.players
      assert game.id == "game-id"
      assert game.away_team.name == "Team A"
      assert player_1.id == "player-1"
      assert player_1.name == "Player 1"
      assert player_1.number == 1
      assert player_2.id == "player-2"
      assert player_2.name == "Player 2"
      assert player_2.number == nil
      assert game.away_team.total_player_stats == %{}

      [player_3, player_4] = game.home_team.players
      assert game.home_team.name == "Team B"
      assert player_3.id == "player-3"
      assert player_3.name == "Player 3"
      assert player_3.number == 3
      assert player_4.id == "player-4"
      assert player_4.name == "Player 4"
      assert player_4.number == nil
      assert game.home_team.total_player_stats == %{}
    end
  end
end
