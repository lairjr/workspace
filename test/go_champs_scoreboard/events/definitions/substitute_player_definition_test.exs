defmodule GoChampsScoreboard.Events.Definitions.SubstitutePlayerDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Games.Models.{GameState, TeamState, PlayerState}

  alias GoChampsScoreboard.Events.Definitions.SubstitutePlayerDefinition
  alias GoChampsScoreboard.Events.Models.Event

  describe "validate/2" do
    test "returns :ok" do
      game_state = %GameState{}

      assert {:ok} =
               SubstitutePlayerDefinition.validate(game_state, %{})
    end
  end

  describe "create/2" do
    test "returns event" do
      assert %Event{key: "substitute-player", game_id: "some-game-id"} =
               SubstitutePlayerDefinition.create("some-game-id", %{
                 "team-type" => "home",
                 "playing-player-id" => "some-id",
                 "bench-player-id" => "some-other-id"
               })
    end
  end

  describe "handle/2" do
    test "returns game state with updated player state" do
      game_state = %GameState{
        away_team: %TeamState{
          players: [
            %PlayerState{
              id: "some-id",
              state: :playing
            },
            %PlayerState{
              id: "some-other",
              state: :bench
            }
          ]
        }
      }

      event_payload = %{
        "team-type" => "away",
        "playing-player-id" => "some-id",
        "bench-player-id" => "some-other"
      }

      event = SubstitutePlayerDefinition.create(game_state.id, event_payload)

      new_game_state = SubstitutePlayerDefinition.handle(game_state, event)

      assert new_game_state.away_team.players == [
               %PlayerState{
                 id: "some-id",
                 state: :bench
               },
               %PlayerState{
                 id: "some-other",
                 state: :playing
               }
             ]
    end
  end
end
