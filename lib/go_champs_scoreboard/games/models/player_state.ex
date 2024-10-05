defmodule GoChampsScoreboard.Games.Models.PlayerState do
  alias GoChampsScoreboard.Sports.Basketball.Basketball

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          number: number(),
          stats_values: map()
        }
  defstruct [:id, :name, :number, :stats_values]

  @spec new(String.t(), String.t(), number(), map()) :: t()
  def new(id, name, number \\ 0, stats_values \\ Basketball.bootstrap()) do
    %__MODULE__{
      id: id,
      name: name,
      number: number,
      stats_values: stats_values
    }
  end
end
