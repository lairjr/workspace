defmodule GoChampsScoreboard.Events.Definitions.UpdateClockStateDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.GameClockState
  alias GoChampsScoreboard.Events.Definitions.UpdateClockStateDefinition

  describe "validate/2" do
    test "returns :ok" do
      game_state = %GameState{}

      assert {:ok} =
               UpdateClockStateDefinition.validate(game_state, %{"state" => "stopped"})
    end
  end

  describe "create/2" do
    test "returns event" do
      assert %Event{key: "update-clock-state", game_id: "some-game-id"} =
               UpdateClockStateDefinition.create("some-game-id", %{"state" => "stopped"})
    end
  end

  describe "handle/2" do
    test "updates the game clock state with given state" do
      game_state = %GameState{
        id: "1",
        sport_id: "basketball",
        clock_state: %GameClockState{
          time: 10,
          period: 1,
          state: :running
        }
      }

      event = UpdateClockStateDefinition.create(game_state.id, %{"state" => "stopped"})

      new_game_state = UpdateClockStateDefinition.handle(game_state, event)

      assert new_game_state.clock_state.time == 10
      assert new_game_state.clock_state.period == 1
      assert new_game_state.clock_state.state == :stopped
    end
  end
end
