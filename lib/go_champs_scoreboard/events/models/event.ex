defmodule GoChampsScoreboard.Events.Models.Event do
  @type t :: %__MODULE__{
          key: String.t(),
          game_id: String.t(),
          timestamp: DateTime.t(),
          payload: any()
        }

  defstruct [:key, :game_id, :timestamp, :payload]

  @spec new(String.t(), String.t()) :: t()
  @spec new(String.t(), String.t(), any()) :: t()
  def new(key, game_id, payload \\ nil) do
    %__MODULE__{
      key: key,
      game_id: game_id,
      timestamp: DateTime.utc_now(),
      payload: payload
    }
  end
end
