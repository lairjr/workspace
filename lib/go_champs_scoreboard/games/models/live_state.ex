defmodule GoChampsScoreboard.Games.Models.LiveState do
  @derive [Poison.Encoder]
  @type state :: :not_started | :in_progress | :ended

  @type t :: %__MODULE__{
          state: state
        }

  defstruct [:state]

  @spec new() :: t()
  @spec new(state()) :: t()
  def new(state \\ :not_started) do
    %__MODULE__{
      state: state
    }
  end

  defimpl Poison.Decoder, for: GoChampsScoreboard.Games.Models.LiveState do
    def decode(
          %{state: state},
          _options
        ) do
      %GoChampsScoreboard.Games.Models.LiveState{
        state: String.to_atom(state)
      }
    end
  end
end
