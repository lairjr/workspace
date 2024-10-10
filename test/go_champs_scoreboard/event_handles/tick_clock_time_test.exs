defmodule GoChampsScoreboard.EventHandles.TickClockTimeTest do
  use ExUnit.Case

  alias GoChampsScoreboard.EventHandles.TickClockTime
  alias GoChampsScoreboard.Games.Models.GameState

  describe "handle/2" do
    test "returns the game state with updated clock time with minus 1 second" do
      game_state = %GameState{
        id: "1",
        clock_time: ~T[00:10:00.000]
      }

      game = TickClockTime.handle(game_state)

      assert game.clock_time == ~T[00:09:59.000]
    end

    test "returns the game state with same clock time if it is 00:00:00.000" do
      game_state = %GameState{
        id: "1",
        clock_time: ~T[00:00:00.000]
      }

      game = TickClockTime.handle(game_state)

      assert game.clock_time == ~T[00:00:00.000]
    end
  end
end
