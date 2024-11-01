defmodule GoChampsScoreboard.Events.StreamConfigs do
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @spec find_for_game_event() :: GoChampsScoreboard.Events.Models.StreamConfig.t()
  def find_for_game_event(event_key \\ "") do
    case event_key do
      _ -> StreamConfig.new()
    end
  end
end
