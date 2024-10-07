defmodule Components.BasketballControls.Views do
  alias GoChampsScoreboard.Games.Models.{GameState}
  use Phoenix.Component

  attr :form_add_new_player, :map, required: true
  attr :game_state, GameState, required: true
  attr :modals, :map, required: true
  attr :selected_team, :string, required: true
  attr :selected_player, :map, required: true

  def general(assigns) do
    ~H"""
    <div class="container">
      <Components.BasketballControls.Game.main game_state={@game_state} />
      <Components.BasketballControls.PlayerStats.view
        game_state={@game_state}
        selected_player={@selected_player}
      />
      <Components.BasketballControls.Modals.modals
        form_add_new_player={@form_add_new_player}
        game_state={@game_state}
        modals={@modals}
        selected_player={@selected_player}
        selected_team={@selected_team}
      />
    </div>
    """
  end
end
