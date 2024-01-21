defmodule GameTest do
  alias Hangman.Impl.Game
  use ExUnit.Case
  doctest Game

  test "creates a new game" do
    game = Game.new()
    assert game.letters != nil
    assert length(game.letters) > 0
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.used == MapSet.new()
  end

  test "creates a new game with provided word" do
    game = Game.new("test")
    assert game.letters == ["t", "e", "s", "t"]
  end

  test "all letters are lowercase ASCII characters" do
    game = Game.new()
    assert Enum.all?(game.letters, fn letter -> letter >= "a" && letter <= "z" end)
  end

  test "state does not change if won or lost" do
    for state <- [:won, :lost] do
      game = Game.new()
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_guess(game, "t")
      assert new_game == game
    end
  end

  test "state does not change if lost" do
    game = Game.new("test")
    game = Map.put(game, :game_state, :lost)
    {new_game, _tally} = Game.make_guess(game, "t")
    assert new_game == game
  end

  test "duplicate guesses are not allowed" do
    game = Game.new()
    {new_game, _tally} = Game.make_guess(game, "t")
    assert new_game.game_state != :already_used
    {new_game, _tally} = Game.make_guess(new_game, "r")
    assert new_game.game_state != :already_used
    {new_game, _tally} = Game.make_guess(new_game, "t")
    assert new_game.game_state == :already_used
  end

  test "correct guesses are scored" do
    game = Game.new("test")
    {new_game, _tally} = Game.make_guess(game, "t")
    assert new_game.game_state == :good_guess
  end

  test "incorrect guesses are scored" do
    game = Game.new("test")
    {new_game, _tally} = Game.make_guess(game, "t")
    assert new_game.game_state == :good_guess
    {new_game, _tally} = Game.make_guess(game, "r")
    assert new_game.game_state == :bad_guess
  end

  test "can handle a sequence of guesses" do
    [
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["a", :already_used, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]]
    ]
    |> test_sequence()
  end

  test "can handle a winning game" do
    [
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["a", :already_used, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["h", :good_guess, 6, ["h", "_", "_", "_", "_"], ["a", "h"]],
      ["e", :good_guess, 6, ["h", "e", "_", "_", "_"], ["a", "e", "h"]],
      ["x", :bad_guess, 5, ["h", "e", "_", "_", "_"], ["a", "e", "h", "x"]],
      ["l", :good_guess, 5, ["h", "e", "l", "l", "_"], ["a", "e", "h", "l", "x"]],
      ["o", :won, 5, ["h", "e", "l", "l", "o"], ["a", "e", "h", "l", "o", "x"]]
    ]
    |> test_sequence()
  end

  test "can handle a losing game" do
    [
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["a", :already_used, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["x", :bad_guess, 5, ["_", "_", "_", "_", "_"], ["a", "x"]],
      ["y", :bad_guess, 4, ["_", "_", "_", "_", "_"], ["a", "x", "y"]],
      ["z", :bad_guess, 3, ["_", "_", "_", "_", "_"], ["a", "x", "y", "z"]],
      ["b", :bad_guess, 2, ["_", "_", "_", "_", "_"], ["a", "b", "x", "y", "z"]],
      ["c", :bad_guess, 1, ["_", "_", "_", "_", "_"], ["a", "b", "c", "x", "y", "z"]],
      ["d", :lost, 0, ["h", "e", "l", "l", "o"], ["a", "b", "c", "d", "x", "y", "z"]]
    ]
    |> test_sequence()
  end

  def test_sequence(script) do
    game = Game.new("hello")
    Enum.reduce(script, game, &check_one_guess/2)
  end

  defp check_one_guess(
         [guess, expected_state, expected_turns_left, expected_letters, expected_used],
         game
       ) do
    {game, tally} = Game.make_guess(game, guess)

    assert tally.turns_left == expected_turns_left
    assert tally.game_state == expected_state
    assert tally.letters == expected_letters
    assert tally.used == expected_used

    game
  end
end
