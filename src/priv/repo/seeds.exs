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

alias Rivalry.{Accounts,Teams,Social}

teams = [
  %{
    name: "Alabama",
    message: "Roll Tide!"
  },
  %{
    name: "Auburn",
    message: "War Eagle!"
  },
  %{
    name: "Georgia",
    message: "Go Dawgs!"
  },
  %{
    name: "Texas",
    message: "Hook Em Horns!"
  },
  %{
    name: "Florida",
    message: "Go Gators!"
  }
]

for team <- teams do
  Teams.create_team(team)
end

users = [
  %{
    username: "admin",
    email: "admin@mail.com",
    password: "qwer1234",
    is_admin: true,
    team_id: 1
  },
  %{
    username: "user1",
    email: "user1@mail.com",
    password: "qwer1234",
    is_admin: false,
    team_id: 1
  },
  %{
    username: "user2",
    email: "user2@mail.com",
    password: "qwer1234",
    is_admin: false,
    team_id: 2
  },
  %{
    username: "user3",
    email: "user3@mail.com",
    password: "qwer1234",
    is_admin: false,
    team_id: 3
  },
  %{
    username: "user4",
    email: "user5@mail.com",
    password: "qwer1234",
    is_admin: false,
    team_id: 4
  },
  %{
    username: "user5",
    email: "user5@mail.com",
    password: "qwer1234",
    is_admin: false,
    team_id: 5
  }
]

for user <- users do
  Accounts.create_user(user)
end

# Set up some social tests
[user1, user2, user3, user4] =
  [Accounts.get_user!(1), Accounts.get_user!(2), Accounts.get_user!(3), Accounts.get_user!(4)]

{:ok, fr1} = Social.send_friend_request(user1, user2)
{:ok, fr2} = Social.send_friend_request(user1, user3)
{:ok, _fr3} = Social.send_friend_request(user1, user4)

Social.accept_friend_request(fr1)
Social.accept_friend_request(fr2)
