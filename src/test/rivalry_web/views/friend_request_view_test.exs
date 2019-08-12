defmodule RivalryWeb.FriendRequestViewTest do
  use RivalryWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    content = render_to_string(
      RivalryWeb.FriendRequestView,
      "index.html",
      conn: conn,
      received_requests: [],
      sent_requests: []
    )

    assert String.contains?(content, "New Friend Request")
  end
end
