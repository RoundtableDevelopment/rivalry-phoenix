defmodule Rivalry.TestHelpers do
  alias Rivalry.Accounts

  def user_fixture(attrs \\ %{}) do
    username = "user#{System.unique_integer([:positive])}"

    {:ok, user} =
      attrs
      |> Enum.into(%{
          username: username,
          email: attrs[:email] || "user@mail.com",
          password: attrs[:password] || "password"
         })
      |> Accounts.create_user()

      user
  end
end
