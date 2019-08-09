defmodule RivalryWeb.Admin.UserController do
  use RivalryWeb, :controller
  alias Rivalry.Accounts

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _current_user) do
    users = Accounts.list_users()

    render(conn, "index.html", users: users)
  end

  def delete(conn, %{"id" => id}, _current_user) do
    user = Accounts.get_user!(id)

    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end
end

