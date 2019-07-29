defmodule RivalryWeb.PageController do
  use RivalryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
