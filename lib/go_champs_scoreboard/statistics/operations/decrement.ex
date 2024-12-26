defmodule GoChampsScoreboard.Statistics.Operations.Decrement do
  def calc(current_value, sub_value \\ 1) do
    current_value - sub_value
  end
end
