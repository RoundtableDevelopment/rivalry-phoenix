defmodule Rivalry.TestHelpers do
  alias Rivalry.{Accounts,Social,Teams,Messages}

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

  def friend_request_fixture(attrs \\ %{}) do
    [user1, user2] = [user_fixture(), user_fixture()]

    {:ok, friend_request} =
      attrs
      |> Enum.into(%{
            user_id: attrs[:user_id] || user1.id,
            friend_id: attrs[:friend_id] || user2.id,
            status: attrs[:status] || "pending",
            accepted_at: attrs[:accepted_at] || nil
         })
      |> Social.create_friend_request()

    friend_request
  end

  def user_friend_fixture(attrs \\ %{}) do
    [user1, user2] = [user_fixture(), user_fixture()]
    friend_request = friend_request_fixture(%{user_id: user1.id, friend_id: user2.id})

    {:ok, user_friend} =
      attrs
      |> Enum.into(%{
          user_id: attrs[:user_id] || user1.id,
          friend_id: attrs[:friend_id] || user2.id,
          friend_request_id: attrs[:friend_request_id] || friend_request.id,
         })
      |> Social.create_user_friend()

    user_friend
  end

  def shout_fixture(attrs \\ %{}) do
    [user1, user2] = [user_fixture(), user_fixture()]

    {:ok, shout} =
      attrs
      |> Enum.into(%{
            sender_id: attrs[:user_id] || user1.id,
            recipient_id: attrs[:friend_id] || user2.id
         })
      |> Messages.create_shout()

    shout
  end
end
