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
      <GoChampsScoreboardWeb.CoreComponents.modal id="add_new_player">
        <div class="box">
          <h2>Add a player</h2>
        </div>
      </GoChampsScoreboardWeb.CoreComponents.modal>
    </div>
    """
  end
end
