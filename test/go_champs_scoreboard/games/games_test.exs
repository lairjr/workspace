defmodule GoChampsScoreboard.Games.GamesTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Events.Definitions.UpdateClockStateDefinition
  alias GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition
  alias GoChampsScoreboard.Events.Definitions.EndGameLiveModeDefinition
  alias GoChampsScoreboard.Games.Games
  alias GoChampsScoreboard.Games.Models.TeamState
  alias GoChampsScoreboard.Games.Models.GameState
  alias GoChampsScoreboard.Games.Models.GameClockState

  import Mox

  setup :verify_on_exit!

  @http_client GoChampsScoreboard.HTTPClientMock
  @resource_manager GoChampsScoreboard.Games.ResourceManagerMock

  describe "find_or_bootstrap/1 when game is set" do
    test "returns game_state" do
      set_test_game()

      result_game_state = Games.find_or_bootstrap("some-game-id")

      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Some away team"
      assert result_game_state.home_team.name == "Some home team"

      unset_test_game()
    end
  end

  describe "find_or_bootstrap/1 when game is not set" do
    test "bootstraps game from go champs, store it and returns it" do
      set_go_champs_api_respose()

      result_game_state = Games.find_or_bootstrap("some-game-id", "token")

      {:ok, stored_game} = Redix.command(:games_cache, ["GET", "some-game-id"])

      redis_game = GameState.from_json(stored_game)

      assert redis_game.id == "some-game-id"
      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Go champs away team"
      assert result_game_state.home_team.name == "Go champs home team"

      unset_test_game()
    end
  end

  describe "start_live_mode/1" do
    test "starts up ResourceManager and returns a handled StartGameLiveMode game state" do
      set_test_game()

      event = StartGameLiveModeDefinition.create("some-game-id", %{})
      handled_game = get_test_game() |> StartGameLiveModeDefinition.handle(event)

      expect(@resource_manager, :start_up, fn _game_id ->
        :ok
      end)

      result_game = Games.start_live_mode("some-game-id", @resource_manager)

      assert handled_game == result_game

      unset_test_game()
    end
  end

  describe "end_live_mode/1" do
    test "shuts down ResourceManager and returns a handled EndGameLiveMode game state" do
      set_test_game()

      event = EndGameLiveModeDefinition.create("some-game-id", %{})
      handled_game = get_test_game() |> EndGameLiveModeDefinition.handle(event)

      expect(@resource_manager, :shut_down, fn _game_id ->
        :ok
      end)

      result_game = Games.end_live_mode("some-game-id", @resource_manager)

      assert handled_game == result_game

      unset_test_game()
    end
  end

  describe "react_to_event/2 for started game" do
    test "when UpdateClockState event is given, returns a game handled by the event" do
      set_test_game()

      event = UpdateClockStateDefinition.create("some-game-id", %{"state" => "running"})
      handled_game = get_test_game() |> UpdateClockStateDefinition.handle(event)

      result_game_state = Games.react_to_event(event, "some-game-id")

      assert result_game_state == handled_game

      unset_test_game()
    end
  end

  describe "update_team" do
    test "return a game state with given updated team" do
      game_state = %GameState{
        id: "some-game-id",
        away_team: %TeamState{name: "Some away team"},
        home_team: %TeamState{name: "Some home team"}
      }

      updated_team = %TeamState{name: "Updated home team"}

      result_game_state = Games.update_team(game_state, "home", updated_team)

      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Some away team"
      assert result_game_state.home_team.name == "Updated home team"
    end
  end

  describe "update_clock_state" do
    test "return a game state with given updated clock state" do
      game_state = %GameState{
        id: "some-game-id",
        away_team: %TeamState{name: "Some away team"},
        home_team: %TeamState{name: "Some home team"},
        clock_state: %GameClockState{time: 10, period: 1, state: :running}
      }

      updated_clock_state = %GameClockState{time: 9, period: 1, state: :running}

      result_game_state = Games.update_clock_state(game_state, updated_clock_state)

      assert result_game_state.id == "some-game-id"
      assert result_game_state.away_team.name == "Some away team"
      assert result_game_state.home_team.name == "Some home team"
      assert result_game_state.clock_state.time == 9
      assert result_game_state.clock_state.period == 1
      assert result_game_state.clock_state.state == :running
    end
  end

  defp set_go_champs_api_respose() do
    response_body = %{
      "data" => %{
        "id" => "some-game-id",
        "away_team" => %{
          "name" => "Go champs away team"
        },
        "home_team" => %{
          "name" => "Go champs home team"
        }
      }
    }

    expect(@http_client, :get, fn url, headers ->
      assert url =~ "some-game-id"
      assert headers == [{"Authorization", "Bearer token"}]

      {:ok, %HTTPoison.Response{body: response_body |> Poison.encode!(), status_code: 200}}
    end)
  end

  defp set_test_game() do
    away_team = TeamState.new("Some away team")
    home_team = TeamState.new("Some home team")
    clock_state = GameClockState.new()
    game_state = GameState.new("some-game-id", away_team, home_team, clock_state)
    Redix.command(:games_cache, ["SET", "some-game-id", game_state])
  end

  defp unset_test_game() do
    Redix.command(:games_cache, ["DEL", "some-game-id"])
  end

  defp get_test_game() do
    {:ok, game_json} = Redix.command(:games_cache, ["GET", "some-game-id"])
    GameState.from_json(game_json)
  end
end
