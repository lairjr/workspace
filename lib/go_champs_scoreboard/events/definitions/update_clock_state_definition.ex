defmodule GoChampsScoreboard.Events.Definitions.UpdateClockStateDefinition do
  @behaviour GoChampsScoreboard.Events.Definitions.Definition

  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Games

  @spec handle(GameState.t(), any()) :: GameState.t()
  def handle(game_state, %{"state" => state}) do
    new_clock_state = %{game_state.clock_state | state: String.to_atom(state)}

    game_state
    |> Games.update_clock_state(new_clock_state)
  end
end
