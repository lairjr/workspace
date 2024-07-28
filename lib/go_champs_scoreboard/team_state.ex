defmodule GoChampsScoreboard.TeamState do
  @type t :: %__MODULE__{
    name: String.t(),
    score: integer()
  }
  defstruct [:name, :score]

  @spec new(String.t(), integer()) :: t()
  def new(name, score) do
    %__MODULE__{
      name: name,
      score: score,
    }
  end
end
