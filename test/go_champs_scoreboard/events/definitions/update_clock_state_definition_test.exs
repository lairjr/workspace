defmodule GoChampsScoreboard.Events.Definitions.UpdateClockStateDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.GameClockState
  alias GoChampsScoreboard.EventHandlers.UpdateClockState

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

      new_game_state = UpdateClockState.handle(game_state, %{"state" => "stopped"})

      assert new_game_state.clock_state.time == 10
      assert new_game_state.clock_state.period == 1
      assert new_game_state.clock_state.state == :stopped
    end
  end
end
