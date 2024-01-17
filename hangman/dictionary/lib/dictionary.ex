defmodule Dictionary do
  alias Dictionary.Impl.WordList
  @spec start() :: [String.t()]
  defdelegate start, to: WordList
  @spec random_word(word_list :: [String.t()]) :: String.t()
  defdelegate random_word(word_list), to: WordList
end
