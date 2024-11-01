defmodule GoChampsScoreboard.Infrastructure.GameEventsListener do
  use GenServer
  alias GoChampsScoreboard.Infrastructure.Stream.{PayloadBuilder, Publisher}
  alias GoChampsScoreboard.Events.StreamConfigs
  alias GoChampsScoreboard.Games.Messages.PubSub

  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: via_tuple(game_id))
  end

  def init(game_id) do
    PubSub.subscribe(game_id)

    {:ok, %{game_id: game_id}}
  end

  def handle_info({:update_game, _game_state}, state) do
    IO.inspect("nothing")
    {:noreply, state}
  end

  def handle_info({:game_reacted_to_event, %{event: event} = payload}, state) do
    stream_config = StreamConfigs.find_for_game_event(event.key)

    if stream_config.streamable do
      PayloadBuilder.build(stream_config.payload_builder, payload)
      |> Publisher.publish()
    end

    {:noreply, state}
  end

  defp via_tuple(game_id) do
    {:via, Registry, {GoChampsScoreboard.Infrastructure.GameEventsListenerRegistry, game_id}}
  end
end
