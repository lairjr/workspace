defmodule GoChampsScoreboard.Games.Models.TeamState do
  alias GoChampsScoreboard.Games.Models.PlayerState

  @type t :: %__MODULE__{
          name: String.t(),
          players: list(PlayerState.t()),
          total_player_stats: map()
        }
  defstruct [:name, :players, :total_player_stats]

  @spec new(String.t(), list(PlayerState.t()), map()) :: t()
  def new(name, players \\ [], total_player_stats \\ %{}) do
    %__MODULE__{
      name: name,
      players: players,
      total_player_stats: total_player_stats
    }
  end
end
