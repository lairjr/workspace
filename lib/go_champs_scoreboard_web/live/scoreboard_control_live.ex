defmodule GoChampsScoreboardWeb.ScoreboardControlLive do
  alias GoChampsScoreboard.Events.ValidatorCreator
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Messages.PubSub
  alias GoChampsScoreboard.ApiClient
  alias GoChampsScoreboardWeb.Components.Modals
  use GoChampsScoreboardWeb, :live_view
  require Logger

  def mount(%{"game_id" => game_id}, %{"api_token" => api_token} = _session, socket) do
    if connected?(socket) do
      PubSub.subscribe(game_id)
    end

    {:ok,
     socket
     |> assign(:api_token, api_token)
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
     |> assign_async(:game_state, fn ->
       {:ok, %{game_state: Games.find_or_bootstrap(game_id, api_token)}}
     end)}
  end

  def handle_event("update-player-stat", params, socket) do
    game_id = socket.assigns.game_state.result.id
    {:ok, event} = ValidatorCreator.validate_and_create("update-player-stat", game_id, params)
    Games.react_to_event(event, game_id)
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

  def handle_event("update-clock-state", params, socket) do
    game_id = socket.assigns.game_state.result.id
    {:ok, event} = ValidatorCreator.validate_and_create("update-clock-state", game_id, params)
    Games.react_to_event(event, game_id)
    {:noreply, socket}
  end

  def handle_event("add-player-to-team", params, socket) do
    game_id = socket.assigns.game_state.result.id
    {:ok, event} = ValidatorCreator.validate_and_create("add-player-to-team", game_id, params)
    Games.react_to_event(event, game_id)

    updated_modals =
      socket.assigns.modals
      |> Modals.hide_modal("modal_add_new_player")

    {:noreply,
     socket
     |> assign(:modals, updated_modals)}
  end

  def handle_event("substitute-player", params, socket) do
    game_id = socket.assigns.game_state.result.id
    {:ok, event} = ValidatorCreator.validate_and_create("substitute-player", game_id, params)
    Games.react_to_event(event, game_id)
    {:noreply, socket}
  end

  def handle_event("update-clock-time-and-period", params, socket) do
    game_id = socket.assigns.game_state.result.id

    {:ok, event} =
      ValidatorCreator.validate_and_create("update-clock-time-and-period", game_id, params)

    Games.react_to_event(event, game_id)
    {:noreply, socket}
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

  def handle_event("end-game-live-mode", _, socket) do
    Games.end_live_mode(socket.assigns.game_state.result.id)

    {:noreply, socket}
  end

  def handle_event("start-game-live-mode", _, socket) do
    Games.start_live_mode(socket.assigns.game_state.result.id)

    {:noreply, socket}
  end

  @spec handle_info({:game_reacted_to_event, any()}, any()) :: {:noreply, any()}
  def handle_info({:game_reacted_to_event, %{game_state: game_state}}, socket) do
    updated_socket =
      socket
      |> assign(:game_state, %{socket.assigns.game_state | result: game_state})

    {:noreply, updated_socket}
  end

  def handle_params(%{"game_id" => game_id}, _url, socket) do
    api_token = socket.assigns.api_token

    IO.inspect("Game ID: #{game_id}")
    IO.inspect("API Token: #{api_token}")

    case ApiClient.get_game(game_id, api_token) do
      {:error, reason} ->
        Logger.error("Failed to fetch game state: #{inspect(reason)}")

        {:noreply,
         push_navigate(socket,
           to: ~p"/error"
         )}

      {:ok, _game_state} ->
        {:noreply, socket}
    end
  end
end
