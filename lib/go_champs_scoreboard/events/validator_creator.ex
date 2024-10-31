defmodule GoChampsScoreboard.Events.ValidatorCreator do
  alias GoChampsScoreboard.Events.Definitions.GameTickDefinition
  alias GoChampsScoreboard.Events.Models.Event

  @spec validate_and_create(String.t()) :: Event.t()
  def validate_and_create("game-tick"),
    do: GameTickDefinition.validate_and_create()
end
