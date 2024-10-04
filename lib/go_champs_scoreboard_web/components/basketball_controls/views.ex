defmodule Components.BasketballControls.Views do
  alias GoChampsScoreboard.Games.Models.{GameState}
  use Phoenix.Component

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
      <GoChampsScoreboardWeb.CoreComponents.modal id="add_new_player">
        <header class="modal-card-head">
          <p class="modal-card-title">Add player to <%= @selected_team %></p>
        </header>
        <section class="modal-card-body">
          <form class="form">
            <div class="field is-grouped">
              <div class="control is-expanded">
                <label class="label">Name</label>
                <input class="input" type="text" placeholder="Kobe bryant" />
              </div>

              <div class="control">
                <label class="label">Number</label>
                <input class="input" type="number" placeholder="24" />
              </div>
            </div>
          </form>
        </section>
        <footer class="modal-card-foot">
          <div class="buttons">
            <button class="button is-success">Save changes</button>
            <button class="button">Cancel</button>
          </div>
        </footer>
      </GoChampsScoreboardWeb.CoreComponents.modal>
    </div>
    """
  end
end
