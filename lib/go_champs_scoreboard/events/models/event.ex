defmodule GoChampsScoreboard.Events.Models.Event do
  @type t :: %__MODULE__{
          key: String.t(),
          timestamp: String.t(),
          payload: any()
        }

  defstruct [:key, :timestamp, :payload]

  @spec new(String.t()) :: t()
  @spec new(String.t(), any()) :: t()
  def new(key, payload \\ nil) do
    %__MODULE__{
      key: key,
      timestamp: DateTime.utc_now(),
      payload: payload
    }
  end
end
