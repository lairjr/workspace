defmodule GoChampsScoreboard.EventHandlers.RemovePlayerInTeamTest do
  use ExUnit.Case

  alias GoChampsScoreboard.EventHandlers.RemovePlayerInTeam

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

      game = RemovePlayerInTeam.handle(game_state, remove_player_in_team_payload)
      players = game.home_team.players

      assert Enum.empty?(players)
    end
  end
end
