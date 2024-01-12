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

  test "double of empty list" do
    assert Lists.double([]) == []
  end

  test "double of non-empty list" do
    assert Lists.double([1, 2, 3]) == [2, 4, 6]
  end

  test "map of empty list" do
    assert Lists.map([], fn x -> x * 2 end) == []
  end

  test "map of non-empty list" do
    assert Lists.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
  end
end
