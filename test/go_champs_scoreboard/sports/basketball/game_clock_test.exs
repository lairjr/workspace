defmodule GoChampsScoreboard.Sports.Basketball.GameClockTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Sports.Basketball.GameClock
  alias GoChampsScoreboard.Games.Models.GameClockState

  describe "tick" do
    test "decreases the time by 1 when the game clock is running" do
      game_clock_state = %GameClockState{
        time: 10,
        period: 1,
        state: :running
      }

      expected = %GameClockState{
        time: 9,
        period: 1,
        state: :running
      }

      assert expected == GameClock.tick(game_clock_state)
    end

    test "does not change the time when the game clock is not running" do
      game_clock_state = %GameClockState{
        time: 10,
        period: 1,
        state: :stopped
      }

      expected = %GameClockState{
        time: 10,
        period: 1,
        state: :stopped
      }

      assert expected == GameClock.tick(game_clock_state)
    end

    test "pauses the clock when is running and time is 0" do
      game_clock_state = %GameClockState{
        time: 0,
        period: 1,
        state: :running
      }

      expected = %GameClockState{
        time: 0,
        period: 1,
        state: :paused
      }

      assert expected == GameClock.tick(game_clock_state)
    end
  end
end
