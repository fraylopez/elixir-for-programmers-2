defmodule Hangman do
  alias Hangman.Runtime.Server
  alias Hangman.Type

  @opaque game :: Server.t()
  @type tally :: Type.tally()

  @spec new() :: game
  def new() do
    {:ok, pid} = Hangman.Runtime.Application.start_game()
    pid
  end

  @spec make_guess(game, String.t()) :: tally
  def make_guess(game, guess) do
    GenServer.call(game, {:make_move, guess})
  end

  @spec tally(game) :: Type.tally()
  def tally(game) do
    GenServer.call(game, {:tally})
  end
end
