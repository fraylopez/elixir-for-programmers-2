defmodule Browser1Web.HangmanController do
  use Browser1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    game = Hangman.new()
    tally = Hangman.tally(game)
    put_session(conn, :game, game)
    render(conn, "game.html", tally: tally)
  end

  def update(conn, %{"guess" => guess}) do
  end

  def show(conn, _params) do
  end
end
