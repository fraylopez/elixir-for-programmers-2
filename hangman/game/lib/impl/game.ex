defmodule Hangman.Impl.Game do
  @type t :: %__MODULE__{
          turns_left: integer,
          game_state: Hangman.state(),
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new do
    Dictionary.random_word() |> new()
  end

  def new(word) do
    %__MODULE__{
      letters: word |> String.codepoints()
    }
  end
end
