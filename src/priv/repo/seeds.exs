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

users = [
  %{
    username: "dmcbrayer",
    email: "user@mail.com",
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
