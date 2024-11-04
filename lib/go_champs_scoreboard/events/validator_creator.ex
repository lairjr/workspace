defmodule GoChampsScoreboard.Events.ValidatorCreator do
  alias GoChampsScoreboard.Events.Definitions.Registry
  alias GoChampsScoreboard.Events.Models.Event

  @spec validate_and_create(String.t()) :: Event.t()
  @spec validate_and_create(String.t(), any()) :: Event.t()
  def validate_and_create(key, payload \\ nil) do
    case Registry.get_definition(key) do
      {:ok, definition} ->
        definition.validate_and_create(payload)

      {:error, :not_registered} ->
        {:error, "Event definition not registered for key: #{key}"}
    end
  end
end
