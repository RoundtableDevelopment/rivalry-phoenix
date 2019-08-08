defmodule Rivalry.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rivalry.Accounts.User

  schema "teams" do
    field :name, :string
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
