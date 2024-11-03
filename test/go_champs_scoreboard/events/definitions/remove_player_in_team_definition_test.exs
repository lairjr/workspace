defmodule GoChampsScoreboard.Events.Definitions.RemovePlayerInTeamDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Events.Definitions.RemovePlayerInTeamDefinition

  describe "validate_and_create/0" do
    test "returns :ok and event" do
      assert {:ok, %Event{key: "remove-player-in-team"}} =
               RemovePlayerInTeamDefinition.validate_and_create(%{
                 "team-type" => "home",
                 "player-id" => "some-id"
               })
    end
  end

  describe "handle/2" do
    test "returns game state with player removed" do
      game_state = %GoChampsScoreboard.Games.Models.GameState{
        id: "1",
        away_team: %GoChampsScoreboard.Games.Models.TeamState{
          players: []
        },
        home_team: %GoChampsScoreboard.Games.Models.TeamState{
          players: [
            %GoChampsScoreboard.Games.Models.PlayerState{
              id: "some-id",
              name: "Kobe Bryant",
              number: 24
            }
          ]
        }
      }

      remove_player_in_team_payload = %{
        "team-type" => "home",
        "player-id" => "some-id"
      }

      {:ok, event} =
        RemovePlayerInTeamDefinition.validate_and_create(remove_player_in_team_payload)

      game = RemovePlayerInTeamDefinition.handle(game_state, event)
      players = game.home_team.players

      assert Enum.empty?(players)
    end
  end
end
