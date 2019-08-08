defmodule RivalryWeb.UserController do
  use RivalryWeb, :controller
  alias Rivalry.{Accounts, Teams}
  alias Rivalry.Accounts.User

  plug :load_teams when action in [:edit, :update]

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user_team(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user_team(user, user_params) do
      {:ok, user} ->
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
end

