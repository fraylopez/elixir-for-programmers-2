defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "generates a random word" do
    random_word = Dictionary.start() |> Dictionary.random_word()
    assert random_word !== nil
  end
end
