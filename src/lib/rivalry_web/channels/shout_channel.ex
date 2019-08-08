defmodule RivalryWeb.ShoutChannel do
  use RivalryWeb, :channel

  def join("users:" <> user_id, _params, socket) do
    {:ok, %{message: "Hello"}, assign(socket, :user_id, user_id)}
  end
end
