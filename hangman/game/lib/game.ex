defmodule Game do
  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @type game :: any
  @type tally :: %{
          turns_left: integer,
          game_state: state,
          guesses: list(String.t()),
          used: list(String.t())
        }

  @spec new() :: game
  def new do
  end

  @spec make_guess(game, String.t()) :: {game, tally}
  def make_guess(_game, _guess) do
  end
end
