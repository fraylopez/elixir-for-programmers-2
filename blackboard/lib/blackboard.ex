defmodule Blackboard do
  def hello do
    :world
  end

  def invert({a, b}) do
    {b, a}
  end

  def are_equal(a, a), do: true
  def are_equal(_, _), do: false
end
