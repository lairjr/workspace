defmodule GoChampsScoreboard.Infrastructure.GameLiveModeListener do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__,)
  end

  def init() do
    PubSub.subscribe()
    {:ok, %{}}
  end

  def handle_info({:game_live_mode, game_id, mode}, state) do
    if (mode == "running") do
      game_ticker_supervisor.start(game_id)
    else
      game_ticker_supervisor.stop(game_id)
    end

    {:noreply, state}
  end

end
