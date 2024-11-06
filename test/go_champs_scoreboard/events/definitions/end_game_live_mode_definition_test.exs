defmodule GoChampsScoreboard.Events.Definitions.EndGameLiveModeDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Events.Definitions.EndGameLiveModeDefinition
  alias GoChampsScoreboard.Games.Models.{GameState, LiveState, TeamState}

  describe "validate_and_create/0" do
    test "returns :ok and event" do
      assert {:ok, %Event{key: "end-game-live-mode"}} =
               EndGameLiveModeDefinition.validate_and_create()
    end
  end

  describe "handle/2" do
    test "updates live_state to :ended in GameState" do
      game_state = %GameState{
        id: "1",
        away_team: %TeamState{
          players: []
        },
        home_team: %TeamState{
          players: []
        },
        live_state: %LiveState{state: :running}
      }

      game =
        EndGameLiveModeDefinition.handle(
          game_state,
          nil
        )

      assert game.live_state.state == :ended
    end
  end
end
