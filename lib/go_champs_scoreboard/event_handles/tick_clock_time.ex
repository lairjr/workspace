defmodule GoChampsScoreboard.EventHandles.TickClockTime do
  alias GoChampsScoreboard.Games.Models.GameState

  @spec handle(GameState.t()) :: GameState.t()
  def handle(game_state) do
    case game_state.clock_time do
      ~T[00:00:00.000] -> game_state
      time -> Map.put(game_state, :clock_time, Time.add(time, -1, :second))
    end
  end
end
