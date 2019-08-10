defmodule Rivalry.Social.FriendRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friend_requests" do
    field :accepted_at, :utc_datetime
    field :status, :string
    field :user_id, :id
    field :friend_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  @valid_statuses ["accepted", "pending", "rejected"]
  def changeset(friend_request, attrs) do
    friend_request
    |> cast(attrs, [:status, :user_id, :friend_id, :accepted_at])
    |> validate_required([:status, :user_id, :friend_id])
    |> validate_inclusion(:status, @valid_statuses)
  end
end
