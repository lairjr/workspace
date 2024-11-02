defmodule GoChampsScoreboard.Events.Definitions.AddPlayerToTeamDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.EventHandlers.AddPlayerToTeam
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.TeamState

  describe "handle/2" do
    test "returns the game state with new player" do
      game_state = %GameState{
        id: "1",
        away_team: %TeamState{
          players: []
        },
        home_team: %TeamState{
          players: []
        }
      }

      add_player_to_team_payload = %{
        "team_type" => "home",
        "name" => "Michael Jordan",
        "number" => 23
      }

      game = AddPlayerToTeam.handle(game_state, add_player_to_team_payload)
      [player] = game.home_team.players

      assert player.name == "Michael Jordan"
      assert player.number == 23
    end
  end
end
