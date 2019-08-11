defmodule Rivalry.Social do
  @moduledoc """
  The Social context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias Rivalry.Repo

  alias Rivalry.Social.{FriendRequest,UserFriend}

  def list_friends_for_user(id) do
    user = Repo.get!(Rivalry.Accounts.User, id)
           |> Repo.preload(:friends)

    user.friends
  end

  def send_friend_request(user, friend) do
    create_friend_request(%{user_id: user.id, friend_id: friend.id, status: "pending"})
  end

  def reject_friend_request(friend_request) do
    update_friend_request(friend_request, %{status: "rejected"})
  end

  # This could be refactored to use Multi.run and the existing
  # context functions.
  # See this: https://hexdocs.pm/phoenix/contexts.html#strategies-for-cross-context-workflows
  def accept_friend_request(friend_request) do
    fr_changeset =
      friend_request
      |> FriendRequest.changeset(%{status: "accepted"})

    [friendship_1, friendship_2] = friendship_changesets(friend_request)

    Multi.new
    |> Multi.update(:friend_request, fr_changeset)
    |> Multi.insert(:user_friend_sender, friendship_1)
    |> Multi.insert(:user_friend_receiver, friendship_2)
    |> Repo.transaction()
  end

  @doc """
  This creates the two user_friend sets of attributes
  necessary to create a two-way friendship between users

  """
  def friendship_changesets(friend_request) do
    user = %{
      user_id: friend_request.user_id,
      friend_id: friend_request.friend_id,
      friend_request_id: friend_request.id
    }
    friend = %{
      user_id: friend_request.friend_id,
      friend_id: friend_request.user_id,
      friend_request_id: friend_request.id
    }

    [
      %UserFriend{} |> UserFriend.changeset(user),
      %UserFriend{} |> UserFriend.changeset(friend)
    ]
  end

  @doc """
  Returns the list of friend_requests.

  ## Examples

      iex> list_friend_requests()
      [%FriendRequest{}, ...]

  """
  def list_friend_requests do
    Repo.all(FriendRequest)
  end

  def list_sent_requests_for_user(user) do
    query =
      from f in FriendRequest,
      where: f.user_id == ^user.id,
      where: f.status == "pending",
      preload: [:user, :friend]

    Repo.all(query)
  end

  def list_received_requests_for_user(user) do
    query =
      from f in FriendRequest,
      where: f.friend_id == ^user.id,
      where: f.status == "pending",
      preload: [:user, :friend]

    Repo.all(query)
  end

  @doc """
  Gets a single friend_request.

  Raises `Ecto.NoResultsError` if the Friend request does not exist.

  ## Examples

      iex> get_friend_request!(123)
      %FriendRequest{}

      iex> get_friend_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_friend_request!(id), do: Repo.get!(FriendRequest, id)

  @doc """
  Creates a friend_request.

  ## Examples

      iex> create_friend_request(%{field: value})
      {:ok, %FriendRequest{}}

      iex> create_friend_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_friend_request(attrs \\ %{}) do
    %FriendRequest{}
    |> FriendRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a friend_request.

  ## Examples

      iex> update_friend_request(friend_request, %{field: new_value})
      {:ok, %FriendRequest{}}

      iex> update_friend_request(friend_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_friend_request(%FriendRequest{} = friend_request, attrs) do
    friend_request
    |> FriendRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FriendRequest.

  ## Examples

      iex> delete_friend_request(friend_request)
      {:ok, %FriendRequest{}}

      iex> delete_friend_request(friend_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_friend_request(%FriendRequest{} = friend_request) do
    Repo.delete(friend_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking friend_request changes.

  ## Examples

      iex> change_friend_request(friend_request)
      %Ecto.Changeset{source: %FriendRequest{}}

  """
  def change_friend_request(%FriendRequest{} = friend_request) do
    FriendRequest.changeset(friend_request, %{})
  end

  alias Rivalry.Social.UserFriend

  @doc """
  Returns the list of user_friends.

  ## Examples

      iex> list_user_friends()
      [%UserFriend{}, ...]

  """
  def list_user_friends do
    Repo.all(UserFriend)
  end

  @doc """
  Gets a single user_friend.

  Raises `Ecto.NoResultsError` if the User friend does not exist.

  ## Examples

      iex> get_user_friend!(123)
      %UserFriend{}

      iex> get_user_friend!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_friend!(id), do: Repo.get!(UserFriend, id)

  @doc """
  Creates a user_friend.

  ## Examples

      iex> create_user_friend(%{field: value})
      {:ok, %UserFriend{}}

      iex> create_user_friend(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_friend(attrs \\ %{}) do
    %UserFriend{}
    |> UserFriend.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_friend.

  ## Examples

      iex> update_user_friend(user_friend, %{field: new_value})
      {:ok, %UserFriend{}}

      iex> update_user_friend(user_friend, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_friend(%UserFriend{} = user_friend, attrs) do
    user_friend
    |> UserFriend.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserFriend.

  ## Examples

      iex> delete_user_friend(user_friend)
      {:ok, %UserFriend{}}

      iex> delete_user_friend(user_friend)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_friend(%UserFriend{} = user_friend) do
    Repo.delete(user_friend)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_friend changes.

  ## Examples

      iex> change_user_friend(user_friend)
      %Ecto.Changeset{source: %UserFriend{}}

  """
  def change_user_friend(%UserFriend{} = user_friend) do
    UserFriend.changeset(user_friend, %{})
  end
end
