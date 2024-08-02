defmodule GoChampsScoreboard.Games.BootstrapperTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.Bootstrapper

  describe "bootstrap" do
    test "bootstraps with random game-id" do
      game = Bootstrapper.bootstrap()
      assert String.length(game.id) > 0
    end

    test "bootstraps with home team and away team" do
      game = Bootstrapper.bootstrap()
      assert game.away_team.name == "Away team"
      assert game.home_team.name == "Home team"
    end
  end

  describe "bootstrap_from_api" do
    test "maps game id" do
    end
  end
end
