defmodule RivalryWeb.FriendRequestController do
  use RivalryWeb, :controller
  alias Rivalry.Social

  def index(conn, _) do
    current_user = conn.assigns.current_user

    received_requests = Social.list_received_requests_for_user(current_user)
    sent_requests = Social.list_sent_requests_for_user(current_user)

    render(conn, "index.html", received_requests: received_requests, sent_requests: sent_requests)
  end

  def accept(conn, %{"id" => id}) do
    friend_request = Social.get_friend_request!(id)
    current_user = conn.assigns.current_user
    received_requests = Social.list_received_requests_for_user(current_user)
    sent_requests = Social.list_sent_requests_for_user(current_user)

    case Social.accept_friend_request(friend_request) do
      {:ok, _friend_request} ->
          conn
          |> put_flash(:info, "Friend request accepted")
          |> redirect(to: Routes.friend_request_path(conn, :index))

      {:error, _changeset} ->
        render(conn, "index.html", received_requests: received_requests, sent_request: sent_requests)
    end
  end

  def reject(conn, %{"id" => id}) do
    friend_request = Social.get_friend_request!(id)

    current_user = conn.assigns.current_user
    received_requests = Social.list_received_requests_for_user(current_user)
    sent_requests = Social.list_sent_requests_for_user(current_user)

    case Social.reject_friend_request(friend_request) do
      {:ok, _friend_request} ->
          conn
          |> put_flash(:info, "Friend request rejected")
          |> redirect(to: Routes.friend_request_path(conn, :index))

      {:error, _changeset} ->
        render(conn, "index.html", received_requests: received_requests, sent_request: sent_requests)
    end
  end

  def delete(conn, %{"id" => id}) do
    friend_request = Social.get_friend_request!(id)
    {:ok, _friend_request} = Social.delete_friend_request(friend_request)

    conn
    |> put_flash(:info, "Friend request rejected")
    |> redirect(to: Routes.friend_request_path(conn, :index))
  end
end
