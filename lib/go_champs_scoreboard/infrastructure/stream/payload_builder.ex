defmodule GoChampsScoreboard.Infrastructure.Stream.PayloadBuilder do
  alias GoChampsScoreboard.Infrastructure.Stream.Models.PublishPayload

  @spec build(atom(), any()) :: PublishPayload.t()
  def build(:generic_game_event_builder, message_body) do
    PublishPayload.new(message_body, "game-events")
  end

  @spec build(atom(), any()) :: PublishPayload.t()
  def build(:generic_game_event_player_stat_builder, message_body) do
    PublishPayload.new(message_body, "game-events.player-stats")
  end

  @spec build(atom(), any()) :: PublishPayload.t()
  def build(:generic_game_event_team_stat_builder, message_body) do
    PublishPayload.new(message_body, "game-events.team-stats")
  end

  @spec build(atom(), any()) :: PublishPayload.t()
  def build(:generic_game_event_live_mode_builder, message_body) do
    PublishPayload.new(message_body, "game-events.live-mode")
  end
end
