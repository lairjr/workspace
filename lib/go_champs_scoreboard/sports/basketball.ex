defmodule GoChampsScoreboard.Sports.Basketball do
  @player_stats [
    %{key: "points"},
    %{key: "rebounds"},
    %{key: "assists"},
    %{key: "fouls"}
  ]
  def bootstrap() do
    Enum.reduce(@player_stats, %{}, fn stat, player_stats ->
      Map.merge(player_stats, %{[stat.key] => 0})
    end)
  end
end
