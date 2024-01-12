defmodule Lists do
  def len([]), do: 0
  def len([_ | tail]), do: 1 + len(tail)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def double([]), do: []
  def double([head | tail]), do: [head * 2 | double(tail)]

  def map([], _fun), do: []
  def map([head | tail], fun), do: [fun.(head) | map(tail, fun)]
end
