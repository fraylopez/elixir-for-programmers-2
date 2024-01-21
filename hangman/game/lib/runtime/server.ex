defmodule Hangman.Runtime.Server do
  alias Hangman.Impl.Game
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, Game.new()}
  end

  def handle_call({:make_move, guess}, _from, state) do
    {updated_game, tally} = Game.make_guess(state, guess)
    {:reply, tally, updated_game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end