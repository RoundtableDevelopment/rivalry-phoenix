defmodule Rivalry.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rivalry.Teams.Team

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean, default: false
    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :team_id, :is_admin])
    |> validate_required([:username, :email, :password])
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:username)
    |> put_pass_hash()
  end

  def team_changeset(user, attrs) do
    user
    |> cast(attrs, [:team_id])
    |> validate_required([:team_id])
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
