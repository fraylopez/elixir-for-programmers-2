defmodule Blackboard do
  def hello do
    :world
  end

  def invert({a, b}) do
    {b, a}
  end

  def are_equal(a, b) do
    a == b
  end
end
