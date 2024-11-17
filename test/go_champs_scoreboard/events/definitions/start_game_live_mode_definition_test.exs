defmodule GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinitionTest do
  use ExUnit.Case

  alias GoChampsScoreboard.Games.Models.{GameState, LiveState, TeamState}

  alias GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition
  alias GoChampsScoreboard.Events.Models.Event

  describe "validate/2" do
    test "returns :ok" do
      game_state = %GameState{}

      assert {:ok} =
               StartGameLiveModeDefinition.validate(game_state, %{})
    end
  end

  describe "create/2" do
    test "returns event" do
      assert %Event{key: "start-game-live-mode", game_id: "some-game-id"} =
               StartGameLiveModeDefinition.create("some-game-id", %{})
    end
  end

  describe "handle/2" do
    test "updates live_mode to :running in GameState" do
      game_state = %GameState{
        id: "1",
        away_team: %TeamState{
          players: []
        },
        home_team: %TeamState{
          players: []
        },
        live_state: %LiveState{state: :not_started}
      }

      game =
        StartGameLiveModeDefinition.handle(
          game_state,
          %{}
        )

      assert game.live_state.state == :running
    end
  end
end
