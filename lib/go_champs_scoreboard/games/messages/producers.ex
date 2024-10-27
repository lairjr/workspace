defmodule GoChampsScoreboard.Games.Messages.Producers do
  alias GoChampsScoreboard.Infrastructure.RabbitMQ
  alias GoChampsScoreboard.Games.Models.GameState

  @spec publish_game_event(GameState.t()) :: :ok
  def publish_game_event(game_state, message_broker \\ RabbitMQ) do
    message_broker.publish(to_string(game_state))
  end
end
