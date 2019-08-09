defmodule Rivalry.TestHelpers do
  alias Rivalry.Accounts
  alias Rivalry.Teams

  def user_fixture(attrs \\ %{}) do
    username = "user#{System.unique_integer([:positive])}"

    {:ok, user} =
      attrs
      |> Enum.into(%{
          username: username,
          email: attrs[:email] || "user@mail.com",
          password: attrs[:password] || "password",
          is_admin: attrs[:is_admin] || false
         })
      |> Accounts.create_user()

      user
  end

  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{name: attrs[:name] || "Alabama"})
      |> Teams.create_team()

    team
  end
end
