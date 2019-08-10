defmodule RivalryWeb.FriendRequestController do
  use RivalryWeb, :controller
  alias Rivalry.Social

  def index(conn, _) do
    current_user = conn.assigns.current_user

    received_requests = Social.list_received_requests_for_user(current_user)
    sent_requests = Social.list_sent_requests_for_user(current_user)

    render(conn, "index.html", received_requests: received_requests, sent_requests: sent_requests)
  end
end
