defmodule Dictionary.Impl.WordList do
  def start() do
    "assets/words.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def random_word(word_list) do
    word_list |> Enum.random()
  end
end
