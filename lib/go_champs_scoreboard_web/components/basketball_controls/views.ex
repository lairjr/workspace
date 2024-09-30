defmodule Components.BasketballControls.Views do
  alias GoChampsScoreboard.Games.Models.GameState
  use Phoenix.Component

  attr :game_state, GameState, required: true

  def general(assigns) do
    ~H"""
    <div class="container">
      <Components.BasketballControls.Game.main
        game_state={@game_state} />
      <Components.BasketballControls.PlayerStats.view
        game_state={@game_state}
        selected_player={@selected_player}
      />
    </div>
    """
  end
end
