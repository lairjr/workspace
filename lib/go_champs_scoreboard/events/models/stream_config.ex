defmodule GoChampsScoreboard.Events.Models.StreamConfig do
  @type t :: %__MODULE__{
          streamable: boolean(),
          payload_builder: atom()
        }

  defstruct [:streamable, :payload_builder]

  @spec new() :: t()
  @spec new(boolean()) :: t()
  @spec new(boolean(), atom()) :: t()
  def new(streamable \\ false, payload_builder \\ :generic_game_event_builder) do
    %__MODULE__{
      streamable: streamable,
      payload_builder: payload_builder
    }
  end
end
