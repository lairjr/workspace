defmodule GoChampsScoreboardWeb.ScoreboardControlLive do
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Clock
  alias GoChampsScoreboardWeb.Components.Modals
  use GoChampsScoreboardWeb, :live_view
  require Logger

  def mount(%{"game_id" => game_id}, _session, socket) do
    if connected?(socket) do
      Games.subscribe(game_id)
      send(self(), :tick)
    end

    {:ok,
     socket
     |> assign(:selected_player, %{player_id: "", team_type: ""})
     |> assign(:selected_team, "")
     |> assign(:modals, Modals.bootstrap(["modal_team_box_score", "modal_add_new_player"]))
     |> assign(
       :form_add_new_player,
       to_form(%{
         "name" => "",
         "number" => 0,
         "team_type" => ""
       })
     )
     |> assign_async(:game_state, fn -> {:ok, %{game_state: Games.find_or_bootstrap(game_id)}} end)}
  end

  def handle_event("update-team-score", value, socket) do
    # {:ok, new_game} = Games.inc_away(socket.assigns.game_state)
    Logger.info("Inc score Event")
    Games.handle_event(socket.assigns.game_state.result.id, "update-team-score", value)
    {:noreply, socket}
  end

  def handle_event("update-player-stat", value, socket) do
    Games.handle_event(socket.assigns.game_state.result.id, "update-player-stat", value)
    {:noreply, socket}
  end

  def handle_event("select-player", %{"player-id" => player_id, "team-type" => team_type}, socket) do
    {:noreply,
     socket
     |> assign(:selected_player, %{player_id: player_id, team_type: team_type})}
  end

  def handle_event("select-team", %{"team-type" => team_type}, socket) do
    {:noreply,
     socket
     |> assign(:selected_team, team_type)}
  end

  def handle_event("add-player-to-team", params, socket) do
    Games.handle_event(socket.assigns.game_state.result.id, "add-player-to-team", params)

    updated_modals =
      socket.assigns.modals
      |> Modals.hide_modal("modal_add_new_player")

    {:noreply,
     socket
     |> assign(:modals, updated_modals)}
  end

  def handle_event("show-add-player-to-team", %{"team-type" => team_type}, socket) do
    updated_modals =
      socket.assigns.modals
      |> Modals.show_modal("modal_add_new_player")

    {:noreply,
     socket
     |> assign(:selected_team, team_type)
     |> assign(:modals, updated_modals)}
  end

  def handle_event("show-team-box-score", %{"team-type" => team_type}, socket) do
    updated_modals =
      socket.assigns.modals
      |> Modals.show_modal("modal_team_box_score")

    {:noreply,
     socket
     |> assign(:selected_team, team_type)
     |> assign(:modals, updated_modals)}
  end

  def handle_event("hide-modal", %{"modal_id" => modal_id}, socket) do
    updated_modals =
      socket.assigns.modals
      |> Modals.hide_modal(modal_id)

    {:noreply,
     socket
     |> assign(:modals, updated_modals)}
  end

  def handle_info(:tick, socket) do
    send(self(), :tick)
    IO.inspect(Games.get_game_time(socket.assigns.game_id))
    IO.inspect("Tick")
    {:noreply, socket}
  end

  # def handle_info(:tick, socket) do
  #   Games.handle_event(socket.assigns.game_state.result.id, "tick-clock-time", nil)
  #   {:noreply, socket}
  # end

  @spec handle_info({:update_game, any()}, any()) :: {:noreply, any()}
  def handle_info({:update_game, game}, socket) do
    updated_socket = socket
    |> assign(:game_state, %{socket.assigns.game_state | result: game})
    {:noreply, updated_socket}
  end
end
