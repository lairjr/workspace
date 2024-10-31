defmodule GoChampsScoreboard.EventHandlers.EndGameLiveMode do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisor
  alias GoChampsScoreboard.Infrastructure.GameTickerSupervisor

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(
        game_state,
        game_events_listener_supervisor \\ GameEventsListenerSupervisor,
        game_ticker_supervisor \\ GameTickerSupervisor
      ) do
    game_events_listener_supervisor.stop_game_events_listener(game_state.id)
    game_ticker_supervisor.stop_game_ticker(game_state.id)

    %{game_state | live_state: %{state: :ended}}
  end
end
