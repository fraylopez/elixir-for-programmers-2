defmodule TextClient.Impl.Player do
  @type game :: Hangman.Game.t()
  @type tally :: Hangman.Tally.t()
  @type state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state :: state()) :: :ok
  def interact({game, tally} = %{game_state: :won}) do
    IO.puts("You won!")
    IO.puts("The word was #{game.word}")
    IO.puts("You had #{tally.turns_left} turns left")
    :ok
  end

  def interact({game, tally} = %{game_state: :lost}) do
    IO.puts("You lost!")
    IO.puts("The word was #{game.word}")
    IO.puts("You had #{tally.turns_left} turns left")
    :ok
  end

  def interact({game, tally}) do
    IO.puts(feedback(tally))
    # interact()
  end

  defp feedback(tally = %{game_state: :initializing}) do
    "Welcome to Hangman!" <>
      "\n" <>
      "The word is #{tally.letters |> Enum.count()} letters long"
  end

  defp feedback(tally = %{game_state: :good_guess}), do: "Good guess!"
  defp feedback(tally = %{game_state: :bad_guess}), do: "Bad guess!"
end
