defmodule RivalryWeb.ShoutChannel do
  use RivalryWeb, :channel

  alias Rivalry.Accounts

  def join("users:" <> user_id, params, socket) do
    {:ok, %{message: "Hello"}, assign(socket, :user_id, user_id)}
  end
end
