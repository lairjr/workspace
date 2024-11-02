defmodule GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinitionTest do
  use ExUnit.Case
  import Mox

  alias GoChampsScoreboard.Games.Models.{GameState, LiveState, TeamState}
  alias GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisorMock
  alias GoChampsScoreboard.Infrastructure.GameTickerSupervisorMock

  alias GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition
  alias GoChampsScoreboard.Events.Models.Event

  describe "validate_and_create/0" do
    test "returns :ok and event" do
      assert {:ok, %Event{key: "start-game-live-mode"}} =
               StartGameLiveModeDefinition.validate_and_create()
    end
  end

  describe "handle/2" do
    test "starts GameTicker, starts GameEventListener, and updates live_mode to :running in GameState" do
      game_state = %GameState{
        id: "1",
        away_team: %TeamState{
          players: []
        },
        home_team: %TeamState{
          players: []
        },
        live_state: %LiveState{state: :not_started}
      }

      expect(GameEventsListenerSupervisorMock, :start_game_events_listener, fn _game_id -> :ok end)

      expect(GameTickerSupervisorMock, :start_game_ticker, fn _game_id -> :ok end)

      game =
        StartGameLiveModeDefinition.handle(
          game_state,
          %{},
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      assert game.live_state.state == :running
      verify!()
    end
  end
end
