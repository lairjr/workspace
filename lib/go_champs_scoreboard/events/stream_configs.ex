defmodule GoChampsScoreboard.Events.StreamConfigs do
  alias GoChampsScoreboard.Events.Definitions.Registry
  alias GoChampsScoreboard.Events.Models.StreamConfig

  @spec find_for_game_event() :: GoChampsScoreboard.Events.Models.StreamConfig.t()
  def find_for_game_event(key \\ "") do
    case Registry.get_definition(key) do
      {:ok, definition} ->
        definition.stream_config()

      {:error, :not_registered} ->
        StreamConfig.new()
    end
  end
end
