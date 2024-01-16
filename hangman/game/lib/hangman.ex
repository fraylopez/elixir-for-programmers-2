defmodule Hangman do
  alias Hangman.Impl.Game

  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @opaque game :: Game.t()
  @type tally :: %{
          turns_left: integer,
          game_state: state,
          guesses: list(String.t()),
          used: list(String.t())
        }

  @spec new() :: game
  defdelegate new, to: Game

  @spec make_guess(game, String.t()) :: {game, tally}
  def make_guess(_game, _guess) do
  end
end
