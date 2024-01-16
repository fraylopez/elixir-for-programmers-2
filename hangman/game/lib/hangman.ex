defmodule Hangman do
  alias Hangman.Impl.Game
  alias Hangman.Type

  @opaque game :: Game.t()

  @spec new() :: game
  defdelegate new, to: Game

  @spec make_guess(game, String.t()) :: {game, Type.tally()}
  def make_guess(_game, _guess) do
  end
end
