defmodule GoChampsScoreboard.Games.TeamsTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Games.Models.TeamState
  alias GoChampsScoreboard.Games.Teams

  describe "add_player" do
    test "adds a player to the given team" do
      game_state = %GameState{
        home_team: %TeamState{
          name: "Brazil",
          players: [
            %PlayerState{
              id: 1,
              name: "Pelé",
              stats_values: %{
                "goals" => 1000,
                "assists" => 500
              }
            }
          ]
        }
      }

      player = %PlayerState{
        id: 10,
        name: "Garrincha",
        stats_values: %{
          "goals" => 100,
          "assists" => 50
        }
      }

      assert %GameState{
               home_team: %TeamState{
                 name: "Brazil",
                 players: [
                   %PlayerState{
                     id: 10,
                     name: "Garrincha",
                     stats_values: %{
                       "goals" => 100,
                       "assists" => 50
                     }
                   },
                   %PlayerState{
                     id: 1,
                     name: "Pelé",
                     stats_values: %{
                       "goals" => 1000,
                       "assists" => 500
                     }
                   }
                 ]
               }
             } == Teams.add_player(game_state, "home", player)
    end
  end

  describe "add_player_to_team" do
    test "adds a player to the given team" do
      team = %TeamState{
        name: "Brazil",
        players: [
          %PlayerState{
            id: 1,
            name: "Pelé",
            stats_values: %{
              "goals" => 1000,
              "assists" => 500
            }
          }
        ]
      }

      player = %PlayerState{
        id: 10,
        name: "Garrincha",
        stats_values: %{
          "goals" => 100,
          "assists" => 50
        }
      }

      assert %TeamState{
               name: "Brazil",
               players: [
                 %PlayerState{
                   id: 10,
                   name: "Garrincha",
                   stats_values: %{
                     "goals" => 100,
                     "assists" => 50
                   }
                 },
                 %PlayerState{
                   id: 1,
                   name: "Pelé",
                   stats_values: %{
                     "goals" => 1000,
                     "assists" => 500
                   }
                 }
               ]
             } == Teams.add_player_to_team(team, player)
    end
  end

  describe "find_player" do
    test "returns the player with the given team type and player id" do
      game_state = %GameState{
        home_team: %TeamState{
          players: [
            %PlayerState{
              id: 1,
              name: "Pelé",
              stats_values: %{
                "goals" => 1000,
                "assists" => 500
              }
            }
          ]
        }
      }

      assert %PlayerState{
               id: 1,
               name: "Pelé",
               stats_values: %{
                 "goals" => 1000,
                 "assists" => 500
               }
             } == Teams.find_player(game_state, "home", 1)
    end
  end

  describe "find_team" do
    test "returns the home team if give team_type is 'home'" do
      game_state = %GameState{
        home_team: %TeamState{
          name: "Brazil",
          players: [
            %PlayerState{
              id: 1,
              name: "Pelé",
              stats_values: %{
                "goals" => 1000,
                "assists" => 500
              }
            }
          ]
        }
      }

      assert %TeamState{
               name: "Brazil",
               players: [
                 %PlayerState{
                   id: 1,
                   name: "Pelé",
                   stats_values: %{
                     "goals" => 1000,
                     "assists" => 500
                   }
                 }
               ]
             } == Teams.find_team(game_state, "home")
    end

    test "returns the away team if give team_type is 'away'" do
      game_state = %GameState{
        away_team: %TeamState{
          name: "Argentina",
          players: [
            %PlayerState{
              id: 10,
              name: "Maradona",
              stats_values: %{
                "goals" => 500,
                "assists" => 300
              }
            }
          ]
        }
      }

      assert %TeamState{
               name: "Argentina",
               players: [
                 %PlayerState{
                   id: 10,
                   name: "Maradona",
                   stats_values: %{
                     "goals" => 500,
                     "assists" => 300
                   }
                 }
               ]
             } == Teams.find_team(game_state, "away")
    end

    test "raises an error if the given team type is invalid" do
      game_state = %GameState{}

      assert_raise RuntimeError, "Invalid team type", fn ->
        Teams.find_team(game_state, "invalid")
      end
    end
  end
end
