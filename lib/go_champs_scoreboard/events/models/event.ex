defmodule GoChampsScoreboard.Events.Models.Event do
  alias GoChampsScoreboard.Events.Models.Metadata

  @type t :: %__MODULE__{
          key: String.t(),
          metadata: Metadata.t(),
          payload: any()
        }

  defstruct [:key, :metadata, :payload]

  @spec new(String.t()) :: t()
  @spec new(String.t(), Metadata.t()) :: t()
  @spec new(String.t(), Metadata.t(), any()) :: t()
  def new(key, metadata \\ Metadata.new(), payload \\ nil) do
    %__MODULE__{
      key: key,
      metadata: metadata,
      payload: payload
    }
  end
end
