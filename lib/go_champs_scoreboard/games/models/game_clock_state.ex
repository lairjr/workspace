defmodule GoChampsScoreboard.Games.Models.GameClockState do
  @type t :: %__MODULE__{
          time: integer,
          period: integer,
          status: String.t()
        }

  defstruct [:time, :period, :status]

  @spec new(integer(), integer(), String.t()) :: t()
  def new(time \\ 0, period \\ 1, status \\ "in_hold") do
    %__MODULE__{
      time: time,
      period: period,
      status: status
    }
  end
end
