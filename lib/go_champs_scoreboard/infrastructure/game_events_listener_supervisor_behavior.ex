defmodule GoChampsScoreboard.Infrastructure.GameEventsListenerSupervisorBehavior do
  @callback start_game_events_listener(String.t()) :: :ok | {:error, any()}
  @callback stop_game_events_listener(String.t()) :: :ok | {:error, any()}
end
