defmodule RivalryWeb.ShoutChannel do
  use RivalryWeb, :channel
  alias Rivalry.{Accounts,Messages}

  def join("users:" <> user_id, _params, socket) do
    {:ok, %{message: "Hello"}, assign(socket, :user_id, user_id)}
  end

  def handle_in(event, params, socket) do
    user = Accounts.get_user!(socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_in("send_shout", %{"recipient_id" => recipient_id}, user, socket) do
    recipient = Accounts.get_user!(recipient_id)
    case Messages.send_shout(user, recipient) do
      {:ok, shout} ->
        broadcast!(socket, "send_shout", %{
          id: shout.id,
          sender_id: shout.sender_id,
          recipient_id: shout.recipient_id
        })

        RivalryWeb.Endpoint.broadcast_from!(self(), "users:" <> shout.recipient_id, "received_shout", %{
          id: shout.id,
          sender_id: shout.sender_id,
          recipient_id: shout.recipient_id,
          message: "Hello"
        })

        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
