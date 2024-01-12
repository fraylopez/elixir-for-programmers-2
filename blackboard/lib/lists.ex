defmodule Lists do
  def len([]), do: 0
  def len([_ | tail]), do: 1 + len(tail)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
end
