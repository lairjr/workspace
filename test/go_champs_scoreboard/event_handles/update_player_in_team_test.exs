defmodule GoChampsScoreboard.EventHandles.UpdatePlayerInTeamTest do
  use ExUnit.Case

  alias GoChampsScoreboard.EventHandles.UpdatePlayerInTeam
  alias GoChampsScoreboard.Games.Models.{GameState, TeamState, PlayerState}

  describe "handle/2" do
    test "returns the game state with updated player" do
      game_state = %GameState{
        id: "1",
        away_team: %TeamState{
          players: []
        },
        home_team: %TeamState{
          players: [%PlayerState{id: "some-id", name: "Kobe Bryant", number: 24}]
        }
      }

      update_player_in_team_payload = %{
        "team_type" => "home",
        "player" => %{
          "id" => "some-id",
          "name" => "Michael Jordan",
          "number" => 23
        }
      }

      game = UpdatePlayerInTeam.handle(game_state, update_player_in_team_payload)
      [player] = game.home_team.players

      assert player.name == "Michael Jordan"
      assert player.number == 23
    end
  end
end
