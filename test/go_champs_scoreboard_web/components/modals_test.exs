defmodule GoChampsScoreboardWeb.Components.ModalsTest do
  use ExUnit.Case

  alias GoChampsScoreboardWeb.Components.Modals

  describe "bootstrap" do
    test "returns kep map with is_open set to false for a list of strings" do
      assert %{"modal_one" => %{"is_open" => false}, "modal_two" => %{"is_open" => false}} =
               Modals.bootstrap(["modal_one", "modal_two"])
    end
  end

  describe "show_modal" do
    @modal_state %{"modal_one" => %{"is_open" => false}, "modal_two" => %{"is_open" => false}}

    test "returns a map with the modal open" do
      assert %{"modal_one" => %{"is_open" => true}, "modal_two" => %{"is_open" => false}} =
               Modals.show_modal(@modal_state, "modal_one")
    end
  end

  describe "hide_modal" do
    @modal_state %{"modal_one" => %{"is_open" => true}, "modal_two" => %{"is_open" => false}}

    test "returns a map with the modal closed" do
      assert %{"modal_one" => %{"is_open" => false}, "modal_two" => %{"is_open" => false}} =
               Modals.hide_modal(@modal_state, "modal_one")
    end
  end

  describe "find_modal" do
    @modal_state %{"modal_one" => %{"is_open" => true}, "modal_two" => %{"is_open" => false}}

    test "returns the modal state for the given modal id" do
      assert %{"is_open" => true} == Modals.find_modal(@modal_state, "modal_one")
    end
  end
end
