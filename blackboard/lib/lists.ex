defmodule Lists do
  def len([]), do: 0
  def len([_ | tail]), do: 1 + len(tail)
end
