defmodule GoChampsScoreboard.Games.ResourceManagerTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Games.ResourceManager
  import Mox

  alias GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisorMock
  alias GoChampsScoreboard.Infrastructure.GameTickerSupervisorMock

  describe "check_and_restart/1" do
    test "starts GameTicker for game-id if not running" do
      game_id = "some-game-id"

      expect(GameTickerSupervisorMock, :check_game_ticker, fn _game_id -> {:error, :not_found} end)

      expect(GameEventsListenerSupervisorMock, :check_game_events_listener, fn _game_id -> :ok end)

      expect(GameTickerSupervisorMock, :start_game_ticker, fn _game_id -> :ok end)

      :ok =
        ResourceManager.check_and_restart(
          game_id,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      verify!()
    end

    test "does not start GameTicker for game-id if already running" do
      game_id = "some-game-id"

      expect(GameTickerSupervisorMock, :check_game_ticker, fn _game_id -> :ok end)

      expect(GameEventsListenerSupervisorMock, :check_game_events_listener, fn _game_id -> :ok end)

      :ok =
        ResourceManager.check_and_restart(
          game_id,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      verify!()
    end

    test "starts EventListener for game-id if not running" do
      game_id = "some-game-id"

      expect(GameEventsListenerSupervisorMock, :check_game_events_listener, fn _game_id ->
        {:error, :not_found}
      end)

      expect(GameTickerSupervisorMock, :check_game_ticker, fn _game_id -> :ok end)

      expect(GameEventsListenerSupervisorMock, :start_game_events_listener, fn _game_id -> :ok end)

      :ok =
        ResourceManager.check_and_restart(
          game_id,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      verify!()
    end

    test "does not start EventListener for game-id if already running" do
      game_id = "some-game-id"

      expect(GameEventsListenerSupervisorMock, :check_game_events_listener, fn _game_id -> :ok end)

      expect(GameTickerSupervisorMock, :check_game_ticker, fn _game_id -> :ok end)

      :ok =
        ResourceManager.check_and_restart(
          game_id,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      verify!()
    end
  end

  describe "start_up/1" do
    test "starts EventListener and then GameTicker for game-id" do
      game_id = "some-game-id"

      expect(GameEventsListenerSupervisorMock, :start_game_events_listener, fn _game_id -> :ok end)

      expect(GameTickerSupervisorMock, :start_game_ticker, fn _game_id -> :ok end)

      :ok =
        ResourceManager.start_up(
          game_id,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      verify!()
    end
  end

  describe "shut_down/1" do
    test "stops EventListener and then GameTicker for game-id" do
      game_id = "some-game-id"

      expect(GameEventsListenerSupervisorMock, :stop_game_events_listener, fn _game_id -> :ok end)
      expect(GameTickerSupervisorMock, :stop_game_ticker, fn _game_id -> :ok end)

      :ok =
        ResourceManager.shut_down(
          game_id,
          GameEventsListenerSupervisorMock,
          GameTickerSupervisorMock
        )

      verify!()
    end
  end
end
