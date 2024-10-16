defmodule GoChampsScoreboard.EventHandlers.GameTick do
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Sports.Sports
  alias GoChampsScoreboard.Games.Games

  @spec handle(GameState.t()) :: GameState.t()
  def handle(game_state) do
    new_clock_state =
      game_state.sport_id
      |> Sports.tick(game_state.clock_state)

    game_state
    |> Games.update_clock_state(new_clock_state)
  end
end
