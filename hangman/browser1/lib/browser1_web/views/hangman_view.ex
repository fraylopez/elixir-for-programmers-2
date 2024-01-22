defmodule Browser1Web.HangmanView do
  use Browser1Web, :view

  def contiue_or_try_again(conn, status) when status in [:won, :lost] do
    button("Try Again", to: Routes.hangman_path(conn, :new))
  end

  def contiue_or_try_again(conn, _status) do
    form_for(conn, Routes.hangman_path(conn, :update), [as: "make_move", method: :put], fn f ->
      [
        text_input(f, :guess),
        submit("Guess")
      ]
    end)
  end

  @status_fields %{
    initializing: {"Initializing", "Guess the word!"},
    good_guess: {"Good Guess", "You guessed a correct letter!"},
    bad_guess: {"Bad Guess", "You guessed an incorrect letter!"},
    won: {"You Won!", "You guessed the word!"},
    lost: {"You Lost!", "You ran out of guesses!"},
    already_used: {"Already Used", "You already guessed that letter!"}
  }

  def move_status(move) do
    {class, message} = @status_fields[move]
    "<div class=\"#{class}\">#{message}</div>"
  end

  defdelegate figure_for(status), to: Browser1Web.HangmanView.Helpers.FigureFor
end
