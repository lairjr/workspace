defmodule GoChampsScoreboard.Games.ResourceManager do
  @moduledoc """
  This module is responsible for managing the resources of a game.
  """

  alias GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisor
  alias GoChampsScoreboard.Infrastructure.GameTickerSupervisor

  @spec start_up(String.t(), module(), module()) :: {:ok, pid()}
  def start_up(
        game_id,
        game_events_listener_supervisor \\ GameEventsListenerSupervisor,
        game_ticker_supervisor \\ GameTickerSupervisor
      ) do
    game_events_listener_supervisor.start_game_events_listener(game_id)
    game_ticker_supervisor.start_game_ticker(game_id)

    {:ok, self()}
  end

  @spec shut_down(String.t(), module(), module()) :: :ok
  def shut_down(
        game_id,
        game_events_listener_supervisor \\ GameEventsListenerSupervisor,
        game_ticker_supervisor \\ GameTickerSupervisor
      ) do
    game_events_listener_supervisor.stop_game_events_listener(game_id)
    game_ticker_supervisor.stop_game_ticker(game_id)

    :ok
  end
end
