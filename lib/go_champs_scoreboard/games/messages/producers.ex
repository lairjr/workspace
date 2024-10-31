defmodule GoChampsScoreboard.Games.Messages.Producers do
  alias GoChampsScoreboard.Infrastructure.RabbitMQ
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Events.Models.Event

  @spec publish_game_event(%{event: Event.t(), game_state: GameState.t()}) :: :ok
  def publish_game_event(message_body, message_broker \\ RabbitMQ) do
    message =
      message_body
      |> build_message()

    message_broker.publish(to_string(message))
  end

  @spec build_message(%{event: Event.t(), game_state: GameState.t()}) :: String.t()
  defp build_message(message_body) do
    %{
      metadata: %{
        sender: "go-champs-scoreboard",
        timestamp: DateTime.utc_now(),
        type: "game-event"
      },
      body: message_body
    }
  end
end
