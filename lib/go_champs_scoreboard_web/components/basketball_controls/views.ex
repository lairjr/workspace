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
      <GoChampsScoreboardWeb.CoreComponents.modal id="create_modal">
        <h2>Add a pet.</h2>
      </GoChampsScoreboardWeb.CoreComponents.modal>
      <GoChampsScoreboardWeb.CoreComponents.button phx-click={
        GoChampsScoreboardWeb.CoreComponents.show_modal("create_modal")
      }>
        Add New Pet +
      </GoChampsScoreboardWeb.CoreComponents.button>
    </div>
    """
  end
end
