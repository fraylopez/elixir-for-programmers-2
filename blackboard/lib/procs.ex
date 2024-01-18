defmodule Procs do
  def hello(what) do
    receive do
      msg ->
        # code
        IO.puts("#{what}: #{msg}")
    end

    hello(what)
  end
end
