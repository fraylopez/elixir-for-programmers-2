defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "creates a new game" do
    game = Hangman.Impl.Game.new()
    assert game.letters != nil
    assert length(game.letters) > 0
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.used == MapSet.new()
  end

  test "creates a new game with provided word" do
    game = Hangman.Impl.Game.new("test")
    assert game.letters == ["t", "e", "s", "t"]
  end

  test "all letters are lowercase ASCII characters" do
    game = Hangman.Impl.Game.new()
    assert Enum.all?(game.letters, fn letter -> letter >= "a" && letter <= "z" end)
  end

  test "state does not change if won or lost" do
    for state <- [:won, :lost] do
      game = Hangman.Impl.Game.new()
      game = Map.put(game, :game_state, state)
      {new_game, tally} = Hangman.make_guess(game, "t")
      assert new_game == game
    end
  end

  test "state does not change if lost" do
    game = Hangman.Impl.Game.new("test")
    game = Map.put(game, :game_state, :lost)
    {new_game, tally} = Hangman.make_guess(game, "t")
    assert new_game == game
  end
end
