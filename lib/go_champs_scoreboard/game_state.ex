defmodule GoChampsScoreboard.GameState do
  alias GoChampsScoreboard.TeamState

  @type g :: %__MODULE__{
    id: String.t(),
    away_team: TeamState,
    home_team: TeamState
  }
  defstruct [:id, :away_team, :home_team]

  @spec new(String.t(), GoChampsScoreboard.TeamState, GoChampsScoreboard.TeamState) :: g()
  def new(id, away_team, home_team) do
    %__MODULE__{
      id: id,
      away_team: away_team,
      home_team: home_team
    }
  end

  defimpl String.Chars do
    def to_string(game) do
      Poison.encode!(game)
    end
  end
end
