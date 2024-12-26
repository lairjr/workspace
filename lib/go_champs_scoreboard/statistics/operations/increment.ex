defmodule GoChampsScoreboard.Statistics.Operations.Increment do
  def calc(current_value, sum_value \\ 1) do
    current_value + sum_value
  end
end
