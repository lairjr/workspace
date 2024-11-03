defmodule GoChampsScoreboard.Events.Definitions.AddPlayerToTeamDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Events.Definitions.AddPlayerToTeamDefinition
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.TeamState

  describe "validate_and_create/0" do
    test "returns :ok and event" do
      assert {:ok, %Event{key: "add-player-to-team"}} =
               AddPlayerToTeamDefinition.validate_and_create(%{
                 "team_type" => "home",
                 "name" => "Michael Jordan",
                 "number" => 23
               })
    end
  end

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

      {:ok, event} = AddPlayerToTeamDefinition.validate_and_create(add_player_to_team_payload)

      game = AddPlayerToTeamDefinition.handle(game_state, event)
      [player] = game.home_team.players

      assert player.name == "Michael Jordan"
      assert player.number == 23
    end
  end
end
