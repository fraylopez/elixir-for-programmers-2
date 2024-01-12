defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "generates a random word" do
    assert Dictionary.random_word() !== nil
  end
end
