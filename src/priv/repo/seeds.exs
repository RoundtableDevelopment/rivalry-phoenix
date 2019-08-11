# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rivalry.Repo.insert!(%Rivalry.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rivalry.Accounts
alias Rivalry.Teams
alias Rivalry.Social

users = [
  %{
    username: "admin",
    email: "admin@mail.com",
    password: "qwer1234",
    is_admin: true
  },
  %{
    username: "user1",
    email: "user1@mail.com",
    password: "qwer1234",
    is_admin: false
  },
  %{
    username: "user2",
    email: "user2@mail.com",
    password: "qwer1234",
    is_admin: false
  },
  %{
    username: "user3",
    email: "user3@mail.com",
    password: "qwer1234",
    is_admin: false
  },
  %{
    username: "user4",
    email: "user5@mail.com",
    password: "qwer1234",
    is_admin: false
  },
  %{
    username: "user5",
    email: "user5@mail.com",
    password: "qwer1234",
    is_admin: false
  }
]

teams = ["Alabama", "Auburn", "Georgia", "Texas", "Florida"]

for user <- users do
  Accounts.create_user(user)
end

for team <- teams do
  Teams.create_team(%{name: team})
end

# Set up some social tests
[user1, user2, user3, user4] =
  [Accounts.get_user!(1), Accounts.get_user!(2), Accounts.get_user!(3), Accounts.get_user!(4)]

{:ok, fr1} = Social.send_friend_request(user1, user2)
{:ok, fr2} = Social.send_friend_request(user1, user3)
{:ok, _fr3} = Social.send_friend_request(user1, user4)

Social.accept_friend_request(fr1)
Social.accept_friend_request(fr2)
