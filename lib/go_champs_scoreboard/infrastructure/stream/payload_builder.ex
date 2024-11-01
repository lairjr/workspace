defmodule GoChampsScoreboard.Infrastructure.Stream.PayloadBuilder do
  alias GoChampsScoreboard.Infrastructure.Stream.Models.PublishPayload

  @spec build(atom(), any()) :: PublishPayload.t()
  def build(:generic_game_event_builder, message_body) do
    PublishPayload.new(message_body, "game-events")
  end
end
