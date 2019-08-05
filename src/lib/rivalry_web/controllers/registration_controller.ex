defmodule RivalryWeb.RegistrationController do
  use RivalryWeb, :controller
  alias Rivalry.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"registration" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> RivalryWeb.Auth.login(user)
        |> put_flash(:info, "#{user.username} created")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, %Ecto.Changeset{}, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
