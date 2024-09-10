defmodule GoChampsScoreboard.EventHandles.UpdateTeamScoreTest do
  use ExUnit.Case
  alias GoChampsScoreboard.EventHandles.UpdateTeamScore

  describe "handle" do
    setup do
      current_game = %{
        home_team: %{score: 0},
        away_team: %{score: 0}
      }

      {:ok, current_game: current_game}
    end

    test "adds to the home team score", %{current_game: current_game} do
      payload = %{"operation" => "+", "team-type" => "home", "amount" => "3"}

      updated_game = UpdateTeamScore.handle(current_game, payload)

      assert updated_game.home_team.score == 3
      assert updated_game.away_team.score == 0
    end

    test "subtracts from the home team score", %{current_game: current_game} do
      current_game = %{current_game | home_team: %{score: 5}}
      payload = %{"operation" => "-", "team-type" => "home", "amount" => "2"}

      updated_game = UpdateTeamScore.handle(current_game, payload)

      assert updated_game.home_team.score == 3
      assert updated_game.away_team.score == 0
    end

    test "adds to the away team score", %{current_game: current_game} do
      payload = %{"operation" => "+", "team-type" => "away", "amount" => "4"}

      updated_game = UpdateTeamScore.handle(current_game, payload)

      assert updated_game.away_team.score == 4
      assert updated_game.home_team.score == 0
    end

    test "subtracts from the away team score", %{current_game: current_game} do
      current_game = %{current_game | away_team: %{score: 7}}
      payload = %{"operation" => "-", "team-type" => "away", "amount" => "3"}

      updated_game = UpdateTeamScore.handle(current_game, payload)

      assert updated_game.away_team.score == 4
      assert updated_game.home_team.score == 0
    end

    test "returns error for invalid operation", %{current_game: current_game} do
      payload = %{"operation" => "*", "team-type" => "home", "amount" => "5"}

      assert UpdateTeamScore.handle(current_game, payload) ==
               {:error, "Invalid operation or team type"}
    end

    test "returns error for invalid team type", %{current_game: current_game} do
      payload = %{"operation" => "+", "team-type" => "invalid_team", "amount" => "5"}

      assert UpdateTeamScore.handle(current_game, payload) ==
               {:error, "Invalid operation or team type"}
    end
  end
end
