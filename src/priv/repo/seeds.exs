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

Accounts.create_user(%{
  username: "dmcbrayer",
  email: "user@mail.com",
  password: "qwer1234",
  is_admin: true
})


teams = ["Alabama", "Auburn", "Georgia", "Texas", "Florida"]
for team <- teams do
  Teams.create_team(%{name: team})
end
