defmodule Rivalry.Social.UserFriend do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rivalry.Accounts.User
  alias Rivalry.Social.FriendRequest

  schema "user_friends" do
    belongs_to :user, User
    belongs_to :friend, User
    belongs_to :friend_request, FriendRequest

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_friend, attrs) do
    user_friend
    |> cast(attrs, [:user_id, :friend_id, :friend_request_id])
    |> validate_required([:user_id, :friend_id, :friend_request_id])
  end
end
