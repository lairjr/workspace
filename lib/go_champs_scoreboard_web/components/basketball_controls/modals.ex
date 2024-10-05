defmodule Components.BasketballControls.Modals do
  use Phoenix.Component

  def add_new_player(assigns) do
    ~H"""
    <GoChampsScoreboardWeb.CoreComponents.modal id="add_new_player">
      <.form for={@add_new_player_form} class="form" phx-submit="add-player-to-team">
        <header class="modal-card-head">
          <p class="modal-card-title">Add player to <%= @selected_team %></p>
        </header>
        <section class="modal-card-body">
          <div class="field is-grouped">
            <div class="control is-expanded">
              <GoChampsScoreboardWeb.CoreComponents.input
                label="Name"
                type="text"
                field={@add_new_player_form[:name]}
              />
            </div>

            <div class="control">
              <GoChampsScoreboardWeb.CoreComponents.input
                label="Number"
                type="number"
                field={@add_new_player_form[:number]}
              />
            </div>

            <GoChampsScoreboardWeb.CoreComponents.input
              type="hidden"
              value={@selected_team}
              field={@add_new_player_form[:team_type]}
            />
          </div>
        </section>
        <footer class="modal-card-foot">
          <div class="buttons">
            <button class="button is-success" type="submit">Save changes</button>
            <button class="button">Cancel</button>
          </div>
        </footer>
      </.form>
    </GoChampsScoreboardWeb.CoreComponents.modal>
    """
  end

  def modals(assigns) do
    ~H"""
    <.add_new_player
      add_new_player_form={@add_new_player_form}
      game_state={@game_state}
      selected_player={@selected_player}
      selected_team={@selected_team}
    />
    """
  end
end
