defmodule GoChampsScoreboard.Games.Models.TeamState do
  alias GoChampsScoreboard.Games.Models.PlayerState
  alias GoChampsScoreboard.Sports.Basketball.Basketball

  @type t :: %__MODULE__{
          name: String.t(),
          players: list(PlayerState.t()),
          total_player_stats: map(),
          stats_values: map()
        }
  defstruct [:name, :players, :total_player_stats, :stats_values]

  @spec new(String.t(), list(PlayerState.t()), map()) :: t()
  def new(
        name,
        players \\ [],
        total_player_stats \\ %{},
        stats_values \\ Basketball.bootstrap_team_stats()
      ) do
    %__MODULE__{
      name: name,
      players: players,
      total_player_stats: total_player_stats,
      stats_values: stats_values
    }
  end
end
