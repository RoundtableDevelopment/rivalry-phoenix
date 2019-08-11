defmodule RivalryWeb.FriendRequestController do
  use RivalryWeb, :controller
  alias Rivalry.{Accounts,Social}

  plug :load_requests when action in [:index, :create, :accept, :reject]
  plug :load_friend when action in [:create]

  def index(conn, _) do
    render(conn, "index.html")
  end

  def create(conn, _params) do
    current_user = conn.assigns.current_user
    friend = conn.assigns.friend

    case Social.send_friend_request(current_user, friend) do
      {:ok, _fr} ->
        conn
        |> put_flash(:info, "Friend request successfully sent")
        |> redirect(to: Routes.friend_request_path(conn, :index))
      {:error, _changeset} ->
        render(conn, "index.html")
    end
  end

  def accept(conn, %{"id" => id}) do
    friend_request = Social.get_friend_request!(id)

    case Social.accept_friend_request(friend_request) do
      {:ok, _friend_request} ->
          conn
          |> put_flash(:info, "Friend request accepted")
          |> redirect(to: Routes.friend_request_path(conn, :index))

      {:error, _changeset} ->
        render(conn, "index.html")
    end
  end

  def reject(conn, %{"id" => id}) do
    friend_request = Social.get_friend_request!(id)

    case Social.reject_friend_request(friend_request) do
      {:ok, _friend_request} ->
          conn
          |> put_flash(:info, "Friend request rejected")
          |> redirect(to: Routes.friend_request_path(conn, :index))

      {:error, _changeset} ->
        render(conn, "index.html")
    end
  end

  def delete(conn, %{"id" => id}) do
    friend_request = Social.get_friend_request!(id)
    {:ok, _friend_request} = Social.delete_friend_request(friend_request)

    conn
    |> put_flash(:info, "Friend request rejected")
    |> redirect(to: Routes.friend_request_path(conn, :index))
  end

  defp load_requests(conn, _opts) do
    current_user = conn.assigns.current_user
    received_requests = Social.list_received_requests_for_user(current_user)
    sent_requests = Social.list_sent_requests_for_user(current_user)

    conn
    |> assign(:received_requests, received_requests)
    |> assign(:sent_requests, sent_requests)
  end

  defp load_friend(conn, _opts) do
    %{params: %{"friend_request" => %{"username" => username}}} = conn

    case Accounts.get_user_by_username(username) do
      friend = %Accounts.User{} ->
        assign(conn, :friend, friend)
      nil ->
        conn
        |> put_flash(:info, "No user by that name")
        |> redirect(to: Routes.friend_request_path(conn, :index))
        |> halt()
    end
  end
end
