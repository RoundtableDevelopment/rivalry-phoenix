defmodule Rivalry.Social.FriendRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rivalry.Accounts.User

  schema "friend_requests" do
    field :accepted_at, :utc_datetime
    field :status, :string
    belongs_to :user, User
    belongs_to :friend, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  @valid_statuses ["accepted", "pending", "rejected"]
  def changeset(friend_request, attrs) do
    friend_request
    |> cast(attrs, [:status, :user_id, :friend_id, :accepted_at])
    |> validate_required([:status, :user_id, :friend_id])
    |> validate_self_friend()
    |> validate_inclusion(:status, @valid_statuses)
  end

  def validate_self_friend(changeset) do
    validate_change(changeset, :friend_id, fn :friend_id, friend_id ->
      case changeset.changes.user_id == friend_id do
        true -> [friend_id: "You can't friend yourself"]
        false -> []
      end
    end)
  end
end
