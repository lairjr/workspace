defmodule GoChampsScoreboard.Statistics.Models.PlayerStat do
  alias GoChampsScoreboard.Games.Models.PlayerState

  @type type :: :manual | :calculated
  @type operation_type :: :increment | :decrement
  @type value_calculator :: fun(PlayerState.t() :: float()) | nil

  @type t :: %__MODULE__{
          key: String.t(),
          type: type,
          operations: [operation_type],
          value: float(),
          value_calculator: value_calculator
        }

  defstruct [:key, :type, :operations, :value, :value_calculator]

  @spec new(String.t(), type(), float(), value_calculator()) :: t()
  def new(key, type, operations \\ [:inc, :dec], value \\ 0, value_calculator \\ nil) do
    %__MODULE__{
      key: key,
      type: type,
      operations: operations,
      value: value,
      value_calculator: value_calculator
    }
  end
end
