defmodule GoChampsScoreboard.Games.Models.TeamState do
  alias GoChampsScoreboard.Games.Models.PlayerState

  @type t :: %__MODULE__{
    name: String.t(),
    score: integer(),
    players: list(PlayerState.t()),
    total_player_stats: map()
  }
  defstruct [:name, :score, :players, :total_player_stats]

  @spec new(String.t(), integer(), list(PlayerState.t()), map()) :: t()
  def new(name, score \\ 0, players \\ [], total_player_stats \\ %{}) do
    %__MODULE__{
      name: name,
      score: score,
      players: players,
      total_player_stats: total_player_stats,
    }
  end
end
