defmodule GoChampsScoreboard.Infrastructure.Stream.Publisher do
  alias GoChampsScoreboard.Infrastructure.Stream.Models.PublishPayload
  alias GoChampsScoreboard.Infrastructure.RabbitMQ

  @spec publish(PublishPayload.t()) :: :ok
  def publish(payload, message_broker \\ RabbitMQ) do
    message =
      payload.body
      |> add_metadata()
      |> Poison.encode!()

    message_broker.publish(%{message: message, routing_key: payload.routing_key})
  end

  defp add_metadata(body) do
    %{
      metadata: %{
        sender: "go-champs-scoreboard",
        sent_at: DateTime.utc_now()
      },
      body: body
    }
  end
end
