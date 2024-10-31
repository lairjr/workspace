defmodule GoChampsScoreboard.Events.Models.Metadata do
  @type t :: %__MODULE__{
          timestamp: DateTime.t(),
          streamable: boolean()
        }

  defstruct [:timestamp, :streamable]

  @spec new(boolean()) :: t()
  def new(streamable \\ false) do
    %__MODULE__{
      timestamp: DateTime.utc_now(),
      streamable: streamable
    }
  end
end
