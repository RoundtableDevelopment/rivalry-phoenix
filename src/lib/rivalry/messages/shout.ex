defmodule Rivalry.Messages.Shout do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Rivalry.Accounts.User

  schema "shouts" do
    belongs_to :sender, User
    belongs_to :recipient, User

    timestamps()
  end

  @doc false
  def changeset(shout, attrs) do
    shout
    |> cast(attrs, [:sender_id, :recipient_id])
    |> validate_required([:sender_id, :recipient_id])
  end

  def received_since(query, datetime) do
    from s in query, where: s.created_at > ^datetime
  end
end
