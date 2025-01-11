defmodule GoChampsScoreboard.Statistics.Operations do
  alias GoChampsScoreboard.Statistics.Operations.{Check, Decrement, Increment}

  def calc(current_value, "decrement"),
    do: Decrement.calc(current_value)

  def calc(current_value, "decrement60"),
    do: Decrement.calc(current_value, 60)

  def calc(current_value, "increment"),
    do: Increment.calc(current_value)

  def calc(current_value, "increment60"),
    do: Increment.calc(current_value, 60)

  def calc(current_value, "check"),
    do: Check.calc(current_value)
end
