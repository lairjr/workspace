defmodule GoChampsScoreboard.Games.Games do
  alias GoChampsScoreboard.Events.Models.Event
  alias GoChampsScoreboard.Events.Handler
  alias GoChampsScoreboard.Games.Models.GameClockState
  alias GoChampsScoreboard.Games.Models.TeamState
  alias GoChampsScoreboard.Games.Messages.PubSub
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Bootstrapper

  @spec find_or_bootstrap(String.t()) :: GameState.t()
  def find_or_bootstrap(game_id) do
    EventLister.start_game_events_listener(game_id)
    case get_game(game_id) do
      {:ok, nil} ->
        game_state =
          Bootstrapper.bootstrap()
          |> Bootstrapper.bootstrap_from_go_champs(game_id)

        update_game(game_state)

      {:ok, game} ->
        game
    end
  end

  def start_up do
    StartEventLister.start()
  end

  def dispose do
    StopEventLister.stop()
  end

  def react_to_event(%Event{key: "start-live-mode"} = event, game_state) do
    start_up()

    react_to_event(event, game_state)
  end

  def react_to_event(%Event{key: "end-live-mode"} = event, game_state) do
    reacted_game_state = react_to_event(event, game_state)

    dispose()

    reacted_game_state
  end

  @spec react_to_event(Event.t(), GameState.t()) :: GameState.t()
  def react_to_event(event, game_id) do
    case get_game(game_id) do
      {:ok, nil} ->
        raise RuntimeError, message: "Game not found"

      {:ok, current_game_state} ->
        new_game_state = Handler.handle(current_game_state, event)
        update_game(new_game_state)

        IO.inspect(event)
        PubSub.broadcast_game_reacted_to_event(event, new_game_state)

        new_game_state
    end
  end

  @spec update_team(GameState.t(), String.t(), TeamState.t()) :: GameState.t()
  def update_team(game_state, team_type, team) do
    case team_type do
      "home" ->
        %{game_state | home_team: team}

      "away" ->
        %{game_state | away_team: team}

      _ ->
        raise RuntimeError, message: "Invalid team type"
    end
  end

  @spec update_clock_state(GameState.t(), GameClockState.t()) :: GameState.t()
  def update_clock_state(game_state, clock_state) do
    %{game_state | clock_state: clock_state}
  end

  @spec get_game(String.t()) :: {:ok, GameState.t()} | {:ok, nil} | {:error, any()}
  defp get_game(game_id) do
    case Redix.command(:games_cache, ["GET", game_id]) do
      {:ok, nil} ->
        {:ok, nil}

      {:ok, game_json} ->
        {:ok, GameState.from_json(game_json)}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec update_game(GameState.t()) :: GameState.t()
  defp update_game(game_state) do
    Redix.command(:games_cache, ["SET", game_state.id, game_state])
    game_state
  end
end
