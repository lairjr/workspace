defmodule GoChampsScoreboard.Events.StreamConfigsTest do
  use ExUnit.Case
  alias GoChampsScoreboard.Events.StreamConfigs
  alias GoChampsScoreboard.Events.Models.StreamConfig

  describe "find_for_game_event/1" do
    test "returns a generic stream config" do
      assert %StreamConfig{streamable: false, payload_builder: :generic_game_event_builder} =
               StreamConfigs.find_for_game_event()
    end
  end
end
