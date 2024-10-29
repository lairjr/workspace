defmodule GoChampsScoreboard.Games.Games do
  alias GoChampsScoreboard.Games.Models.GameClockState
  alias GoChampsScoreboard.Games.Models.TeamState
  alias GoChampsScoreboard.EventHandlers
  alias GoChampsScoreboard.Games.Messages.{Producers, PubSub}
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Bootstrapper

  @spec find_or_bootstrap(String.t()) :: GameState.t()
  def find_or_bootstrap(game_id) do
    case Redix.command(:games_cache, ["GET", game_id]) do
      {:ok, nil} ->
        game_state =
          Bootstrapper.bootstrap()
          |> Bootstrapper.bootstrap_from_go_champs(game_id)

        Redix.command(:games_cache, ["SET", game_id, game_state])

        game_state

      {:ok, curr_game_json} ->
        GameState.from_json(curr_game_json)
    end
  end

  @spec handle_event(String.t(), String.t(), any()) :: GameState.t()
  def handle_event(game_id, event, event_payload \\ %{}) do
    current_game_state = find_or_bootstrap(game_id)
    new_game_state = EventHandlers.handle(event, current_game_state, event_payload)
    Redix.command(:games_cache, ["SET", game_id, new_game_state])

    PubSub.broadcast_game_update(game_id, new_game_state)
    Producers.publish_game_event(new_game_state)

    new_game_state
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
end
