defmodule GoChampsScoreboard.Infrastructure.GameEventStreamerSupervisorBehavior do
  @callback check_game_events_listener(String.t()) :: :ok | {:error, any()}
  @callback start_game_events_listener(String.t()) :: :ok | {:error, any()}
  @callback stop_game_events_listener(String.t()) :: :ok | {:error, any()}
end
