defmodule GoChampsScoreboard.Games.Models.PlayerState do
  @type t :: %__MODULE__{
    id: String.t(),
    name: String.t(),
    stats_values: map()
  }
  defstruct [:id, :name, :stats_values]

  @spec new(String.t(), String.t(), map()) :: t()
  def new(id, name, stats_values \\ %{}) do
    %__MODULE__{
      id: id,
      name: name,
      stats_values: stats_values
    }
  end
end
