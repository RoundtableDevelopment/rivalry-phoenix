defmodule RivalryWeb.PageController do
  use RivalryWeb, :controller
  alias Rivalry.Social

  def index(conn, _params) do
    friends =
      if conn.assigns.current_user do
        Social.list_friends_for_user(conn.assigns.current_user.id)
      else
        []
      end

    render(conn, "index.html", friends: friends)
  end
end
