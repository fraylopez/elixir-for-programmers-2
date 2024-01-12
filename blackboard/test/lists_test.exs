defmodule ListsTest do
  use ExUnit.Case
  doctest Lists

  test "length of empty list" do
    assert Lists.len([]) == 0
  end

  test "length of non-empty list" do
    assert Lists.len([1, 2, 3]) == 3
  end
end
