defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "creates a new game" do
    game = Hangman.new()
    assert game.letters != nil
    assert length(game.letters) > 0
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.used == MapSet.new()
  end

  test "creates a new game with provided word" do
    game = Hangman.new("test")
    assert game.letters == ["t", "e", "s", "t"]
  end

  test "all letters are lowercase ASCII characters" do
    game = Hangman.new()
    assert Enum.all?(game.letters, fn letter -> letter >= "a" && letter <= "z" end)
  end

  test "state does not change if won or lost" do
    for state <- [:won, :lost] do
      game = Hangman.new()
      game = Map.put(game, :game_state, state)
      {new_game, tally} = Hangman.make_guess(game, "t")
      assert new_game == game
    end
  end

  test "state does not change if lost" do
    game = Hangman.new("test")
    game = Map.put(game, :game_state, :lost)
    {new_game, _tally} = Hangman.make_guess(game, "t")
    assert new_game == game
  end

  test "duplicate guesses are not allowed" do
    game = Hangman.new()
    {new_game, _tally} = Hangman.make_guess(game, "t")
    assert new_game.game_state != :already_used
    {new_game, _tally} = Hangman.make_guess(new_game, "r")
    assert new_game.game_state != :already_used
    {new_game, _tally} = Hangman.make_guess(new_game, "t")
    assert new_game.game_state == :already_used
  end

  test "correct guesses are scored" do
    game = Hangman.new("test")
    {new_game, _tally} = Hangman.make_guess(game, "t")
    assert new_game.game_state == :good_guess
  end

  test "incorrect guesses are scored" do
    game = Hangman.new("test")
    {new_game, _tally} = Hangman.make_guess(game, "t")
    assert new_game.game_state == :good_guess
    {new_game, _tally} = Hangman.make_guess(game, "r")
    assert new_game.game_state == :bad_guess
  end
end
