defmodule Hangman do
  alias Hangman.Impl.Game
  alias Hangman.Type

  @opaque game :: Game.t()

  @spec new() :: game
  defdelegate new, to: Game

  @spec new(String.t()) :: game
  defdelegate new(wordToGuess), to: Game

  @spec make_guess(game, String.t()) :: {game, Type.tally()}
  defdelegate make_guess(game, guess), to: Game

  @spec tally(game) :: Type.tally()
  defdelegate tally(game), to: Game
end
