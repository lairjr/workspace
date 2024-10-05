defmodule Components.BasketballControls.Views do
  alias GoChampsScoreboard.Games.Models.{GameState}
  use Phoenix.Component

  attr :add_new_player_form, :map, required: true
  attr :game_state, GameState, required: true
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
        add_new_player_form={@add_new_player_form}
        game_state={@game_state}
        selected_player={@selected_player}
        selected_team={@selected_team}
      />
    </div>
    """
  end
end
