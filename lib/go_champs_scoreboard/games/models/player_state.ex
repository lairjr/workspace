defmodule GoChampsScoreboard.Games.Models.PlayerState do
  @type t :: %__MODULE__{
    id: String.t(),
    name: String.t(),
  }
  defstruct [:id, :name]

  @spec new(String.t(), String.t()) :: t()
  def new(id, name) do
    %__MODULE__{
      id: id,
      name: name
    }
  end
end
