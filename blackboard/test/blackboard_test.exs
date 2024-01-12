defmodule BlackboardTest do
  use ExUnit.Case
  doctest Blackboard

  test "greets the world" do
    assert Blackboard.hello() == :world
  end

  test "inverts a tuple" do
    assert Blackboard.invert({:a, :b}) == {:b, :a}
  end

  test "check equality" do
    assert Blackboard.are_equal(1, 1) == true
  end
end
