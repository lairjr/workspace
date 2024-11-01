defmodule GoChampsScoreboard.Events.StreamConfigs do
  alias GoChampsScoreboard.Events.Models.StreamConfig
  alias GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition

  @spec find_for_game_event() :: GoChampsScoreboard.Events.Models.StreamConfig.t()
  def find_for_game_event(key \\ "") do
    case key do
      "start-game-live-mode" -> StartGameLiveModeDefinition.stream_config()
      _ -> StreamConfig.new()
    end
  end
end
