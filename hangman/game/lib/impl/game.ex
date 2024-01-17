defmodule Hangman.Impl.Game do
  alias Hangman.Type

  @type t :: %__MODULE__{
          turns_left: integer,
          game_state: Type.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  @spec new() :: t
  def new do
    Dictionary.random_word() |> new()
  end

  @spec new(String.t()) :: t
  def new(word) do
    %__MODULE__{
      letters: word |> String.codepoints()
    }
  end

  @spec make_guess(t, String.t()) :: {t, Type.tally()}
  def make_guess(game = %{game_state: state}, _guess)
      when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_guess(game, guess) do
    accept_guess(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  defp accept_guess(game, _guess, _already_used = true) do
    %{game | game_state: :already_used}
  end

  defp accept_guess(game, guess, _already_used) do
    %{game | used: MapSet.put(game.used, guess)}
  end

  defp tally(game) do
    %{
      turns_left: game.turns_left,
      game_state: game.game_state,
      letters: [],
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end

  defp return_with_tally(game) do
    tally = %{tally(game) | used: MapSet.to_list(game.used)}
    {game, tally}
  end
end
