defmodule Rivalry.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rivalry.Accounts.User

  schema "teams" do
    field :name, :string
    field :message, :string
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :message])
    |> validate_required([:name, :message])
  end
end
