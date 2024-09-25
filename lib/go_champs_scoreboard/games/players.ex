defmodule GoChampsScoreboard.Games.Players do
  alias GoChampsScoreboard.Statistics.Statistics

  def update_manual_stats_values(player_state, player_stat, operation) do
    new_stat_value =
      fetch_stats_value(player_state, player_stat)
      |> Statistics.calc(operation)

    player_state
    |> update_stats_values(player_stat, new_stat_value)
  end

  def update_calculated_stats_values(player_state, player_stats) do
    player_stats
    |> Enum.reduce(player_state, fn
      player_stat, current_player_state ->
        update_calculated_stat_value(current_player_state, player_stat)
    end)
  end

  def update_calculated_stat_value(player_state, player_stat) do
    new_stat_value =
      player_state
      |> Map.get(player_stat, :calculation_function).()

    player_state
    |> update_stats_values(player_stat, new_stat_value)
  end

  defp fetch_stats_value(player_state, player_stat) do
    Map.fetch!(player_state.stats_values, player_stat.key)
  end

  defp update_stats_values(player_state, player_stat, new_value) do
    %{
      player_state
      | stats_values: Map.replace(player_state.stats_values, player_stat.key, new_value)
    }
  end
end
