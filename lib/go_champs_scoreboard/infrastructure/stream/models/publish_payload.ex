defmodule GoChampsScoreboard.Infrastructure.Stream.Models.PublishPayload do
  @type t :: %__MODULE__{
          body: any(),
          routing_key: String.t()
        }

  defstruct [:body, :routing_key]

  @spec new(any(), String.t()) :: t()
  def new(body, routing_key) do
    %__MODULE__{
      body: body,
      routing_key: routing_key
    }
  end
end
