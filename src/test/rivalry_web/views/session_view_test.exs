defmodule RivalryWeb.SessionViewTest do
  use RivalryWeb.ConnCase, async: true
  import Phoenix.View

  test "renders new.html", %{conn: conn} do
    content = render_to_string(
      RivalryWeb.SessionView,
      "new.html",
      conn: conn
    )

    assert String.contains?(content, "Login")
  end
end
