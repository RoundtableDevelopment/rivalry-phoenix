defmodule RivalryWeb.UserController do
  use RivalryWeb, :controller
  alias Rivalry.{Accounts, Teams}
  alias Rivalry.Accounts.User

  plug :load_user when action in [:edit, :update]
  plug :authorize_user when action in [:edit, :update]
  plug :load_teams when action in [:edit, :update]


  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def edit(conn, _params, _current_user) do
    user = conn.assigns.user
    changeset = Accounts.change_user_team(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}, _current_user) do
    user = conn.assigns.user

    case Accounts.update_user_team(user, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Your profile has been updated successfully")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  defp load_teams(conn, _) do
    assign(conn, :teams, Teams.list_teams_for_select())
  end

  defp load_user(conn, _) do
    %{params: %{"id" => id}} = conn

    case Accounts.get_user(id) do
      user = %User{} ->
        assign(conn, :user, user)
      nil ->
        conn
        |> put_flash(:info, "You cannot access that user")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt()
    end
  end

  defp authorize_user(conn, _) do
    if conn.assigns.current_user == conn.assigns.user do
      conn
    else
      conn
      |> put_flash(:info, "You do not have permission to edit that user")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end

