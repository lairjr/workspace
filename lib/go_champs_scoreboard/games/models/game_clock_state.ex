defmodule GoChampsScoreboard.Games.Models.GameClockState do
  @type state :: :not_started | :running | :paused | :stopped

  @type t :: %__MODULE__{
          time: integer,
          period: integer,
          state: state
        }

  defstruct [:time, :period, :state]

  @spec new(integer(), integer(), String.t()) :: t()
  def new(time \\ 0, period \\ 1, state \\ :not_started) do
    %__MODULE__{
      time: time,
      period: period,
      state: state
    }
  end
end
