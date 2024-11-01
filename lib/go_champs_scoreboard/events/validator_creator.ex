defmodule GoChampsScoreboard.Events.ValidatorCreator do
  alias GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition
  alias GoChampsScoreboard.Events.Definitions.GameTickDefinition
  alias GoChampsScoreboard.Events.Models.Event

  @spec validate_and_create(String.t()) :: Event.t()
  def validate_and_create(key) do
    case key do
      "game-tick" -> GameTickDefinition.validate_and_create()
      "start-game-live-mode" -> StartGameLiveModeDefinition.validate_and_create()
      _ -> {:error, "Invalid event type"}
    end
  end
end
