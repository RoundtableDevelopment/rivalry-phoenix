defmodule Rivalry.Social.UserFriend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_friends" do
    field :user_id, :id
    field :friend_id, :id
    field :friend_request_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_friend, attrs) do
    user_friend
    |> cast(attrs, [:user_id, :friend_id, :friend_request_id])
    |> validate_required([:user_id, :friend_id, :friend_request_id])
  end
end
