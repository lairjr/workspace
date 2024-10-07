defmodule GoChampsScoreboardWeb.Components.Modals do
  @modal_initial_state %{
    "is_open" => false
  }

  def bootstrap(modal_ids) do
    Enum.reduce(modal_ids, %{}, fn modal_id, acc ->
      Map.put(acc, modal_id, @modal_initial_state)
    end)
  end

  def find_modal(modal_state, modal_id) do
    Map.get(modal_state, modal_id, @modal_initial_state)
  end

  def hide_modal(modal_state, modal_id) do
    current_state = Map.get(modal_state, modal_id, @modal_initial_state)
    new_state = %{current_state | "is_open" => false}
    Map.put(modal_state, modal_id, new_state)
  end

  def show_modal(modal_state, modal_id) do
    current_state = Map.get(modal_state, modal_id, @modal_initial_state)
    new_state = %{current_state | "is_open" => true}
    Map.put(modal_state, modal_id, new_state)
  end
end
