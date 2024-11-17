defmodule GoChampsScoreboard.Events.Definitions.UpdatePlayerInTeamDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Events.Definitions.UpdatePlayerInTeamDefinition
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.{GameState, TeamState, PlayerState}

  describe "validate/2" do
    test "returns :ok" do
      game_state = %GameState{}

      assert {:ok} =
               UpdatePlayerInTeamDefinition.validate(game_state, %{
                 "team_type" => "home",
                 "player" => %{
                   "id" => "some-id",
                   "name" => "Michael Jordan",
                   "number" => 23
                 }
               })
    end
  end

  describe "create/2" do
    test "returns event" do
      assert %Event{key: "update-player-in-team", game_id: "some-game-id"} =
               UpdatePlayerInTeamDefinition.create("some-game-id", %{
                 "team_type" => "home",
                 "player" => %{
                   "id" => "some-id",
                   "name" => "Michael Jordan",
                   "number" => 23
                 }
               })
    end
  end

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

      event =
        UpdatePlayerInTeamDefinition.create(game_state.id, update_player_in_team_payload)

      game = UpdatePlayerInTeamDefinition.handle(game_state, event)
      [player] = game.home_team.players

      assert player.name == "Michael Jordan"
      assert player.number == 23
    end
  end
end
