defmodule TextClient.Runtime.RemoteHangman do
  @remote_server :"hangman@Victors-MacBook-Pro"

  def connect() do
    :rpc.call(@remote_server, Hangman, :new, [])
  end
end
