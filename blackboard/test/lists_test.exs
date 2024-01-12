defmodule ListsTest do
  use ExUnit.Case
  doctest Lists

  test "length of empty list" do
    assert Lists.len([]) == 0
  end

  test "length of non-empty list" do
    assert Lists.len([1, 2, 3]) == 3
  end

  test "sum of empty list" do
    assert Lists.sum([]) == 0
  end

  test "sum of non-empty list" do
    assert Lists.sum([1, 2, 3]) == 6
  end

  test "square of empty list" do
    assert Lists.square([]) == []
  end

  test "square of non-empty list" do
    assert Lists.square([1, 2, 3]) == [1, 4, 9]
  end
end
