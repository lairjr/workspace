defmodule GoChampsScoreboard.EventHandlers.EndGameLiveModeTest do
  use ExUnit.Case
  import Mox

  alias GoChampsScoreboard.EventHandlers.EndGameLiveMode
  alias GoChampsScoreboard.Games.Models.{GameState, LiveState, TeamState}
  alias GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisorMock
  alias GoChampsScoreboard.Infrastructure.GameTickerSupervisorMock

  setup :verify_on_exit!

  describe "handle/2" do
    test "terminate GameTicker, terminate GameEventsListener, and updates live_state to :ended in GameState" do
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

      expect(GameEventsListenerSupervisorMock, :stop_game_events_listener, fn _game_id -> :ok end)
      expect(GameTickerSupervisorMock, :stop_game_ticker, fn _game_id -> :ok end)

      game =
        EndGameLiveMode.handle(
          game_state,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      assert game.live_state.state == :ended
      verify!()
    end
  end
end
