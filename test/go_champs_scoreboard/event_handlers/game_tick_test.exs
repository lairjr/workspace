defmodule GoChampsScoreboard.EventHandlers.GameTickTest do
  use ExUnit.Case

  alias GoChampsScoreboard.EventHandlers.GameTick
  alias GoChampsScoreboard.Games.Models.GameState

  describe "handle/1" do
    test "returns the game state with updated game clock for basketball" do
      game_state = %GameState{
        id: "1",
        sport_id: "basketball",
        game_clock: %GameClockState{
          time: 10,
          period: 1,
          status: "in_hold"
        }
      }

      game = GameTick.handle(game_state)

      assert game.game_clock.time == 9
      assert game.game_clock.period == 1
      assert game.game_clock.status == "in_hold"
    end
  end
end
