defmodule GoChampsScoreboard.Games.Models.TeamState do
  alias GoChampsScoreboard.Games.Models.PlayerState

  @type t :: %__MODULE__{
    name: String.t(),
    score: integer(),
    players: list(PlayerState.t())
  }
  defstruct [:name, :score, :players]

  @spec new(String.t(), integer(), list(PlayerState.t())) :: t()
  def new(name, score \\ 0, players \\ []) do
    %__MODULE__{
      name: name,
      score: score,
      players: players,
    }
  end
end
