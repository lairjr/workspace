defmodule GoChampsScoreboard.Sports.Basketball.GameClock do
  alias GoChampsScoreboard.Games.Models.GameClockState

  @spec tick(GameClockState.t()) :: GameClockState.t()
  def tick(%GameClockState{time: time, period: period, state: state}) do
    case state do
      :running when time > 0 -> %GameClockState{time: time - 1, period: period, state: state}
      :running when time == 0 -> %GameClockState{time: time, period: period, state: :paused}
      _ -> %GameClockState{time: time, period: period, state: state}
    end
  end
end
