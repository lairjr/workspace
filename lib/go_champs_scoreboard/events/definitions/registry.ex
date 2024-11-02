defmodule GoChampsScoreboard.Events.Definitions.Registry do
  alias GoChampsScoreboard.Events.Definitions.GameTickDefinition
  alias GoChampsScoreboard.Events.Definitions.StartGameLiveModeDefinition

  @registry %{
    GameTickDefinition.key() => GameTickDefinition,
    StartGameLiveModeDefinition.key() => StartGameLiveModeDefinition
  }

  @spec get_definition(String.t()) :: {:ok, module()} | {:error, :not_registered}
  def get_definition(key) do
    case Map.get(@registry, key) do
      nil -> {:error, :not_registered}
      definition -> {:ok, definition}
    end
  end
end
