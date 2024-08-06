defmodule GoChampsScoreboard.Games.Models.TeamState do
  @type t :: %__MODULE__{
    name: String.t(),
    score: integer()
  }
  defstruct [:name, :score]

  @spec new(String.t(), integer()) :: t()
  def new(name, score \\ 0) do
    %__MODULE__{
      name: name,
      score: score,
    }
  end
end
