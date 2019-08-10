defmodule Rivalry.SocialTest do
  use Rivalry.DataCase

  alias Rivalry.Social

  describe "friend_requests" do
    alias Rivalry.Social.FriendRequest

    @valid_attrs %{accepted_at: ~N[2010-04-17 14:00:00], status: "some status"}
    @update_attrs %{accepted_at: ~N[2011-05-18 15:01:01], status: "some updated status"}
    @invalid_attrs %{accepted_at: nil, status: nil}

    def friend_request_fixture(attrs \\ %{}) do
      {:ok, friend_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_friend_request()

      friend_request
    end

    test "list_friend_requests/0 returns all friend_requests" do
      friend_request = friend_request_fixture()
      assert Social.list_friend_requests() == [friend_request]
    end

    test "get_friend_request!/1 returns the friend_request with given id" do
      friend_request = friend_request_fixture()
      assert Social.get_friend_request!(friend_request.id) == friend_request
    end

    test "create_friend_request/1 with valid data creates a friend_request" do
      assert {:ok, %FriendRequest{} = friend_request} = Social.create_friend_request(@valid_attrs)
      assert friend_request.accepted_at == ~N[2010-04-17 14:00:00]
      assert friend_request.status == "some status"
    end

    test "create_friend_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_friend_request(@invalid_attrs)
    end

    test "update_friend_request/2 with valid data updates the friend_request" do
      friend_request = friend_request_fixture()
      assert {:ok, %FriendRequest{} = friend_request} = Social.update_friend_request(friend_request, @update_attrs)
      assert friend_request.accepted_at == ~N[2011-05-18 15:01:01]
      assert friend_request.status == "some updated status"
    end

    test "update_friend_request/2 with invalid data returns error changeset" do
      friend_request = friend_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_friend_request(friend_request, @invalid_attrs)
      assert friend_request == Social.get_friend_request!(friend_request.id)
    end

    test "delete_friend_request/1 deletes the friend_request" do
      friend_request = friend_request_fixture()
      assert {:ok, %FriendRequest{}} = Social.delete_friend_request(friend_request)
      assert_raise Ecto.NoResultsError, fn -> Social.get_friend_request!(friend_request.id) end
    end

    test "change_friend_request/1 returns a friend_request changeset" do
      friend_request = friend_request_fixture()
      assert %Ecto.Changeset{} = Social.change_friend_request(friend_request)
    end
  end

  describe "user_friends" do
    alias Rivalry.Social.UserFriend

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_friend_fixture(attrs \\ %{}) do
      {:ok, user_friend} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_user_friend()

      user_friend
    end

    test "list_user_friends/0 returns all user_friends" do
      user_friend = user_friend_fixture()
      assert Social.list_user_friends() == [user_friend]
    end

    test "get_user_friend!/1 returns the user_friend with given id" do
      user_friend = user_friend_fixture()
      assert Social.get_user_friend!(user_friend.id) == user_friend
    end

    test "create_user_friend/1 with valid data creates a user_friend" do
      assert {:ok, %UserFriend{} = user_friend} = Social.create_user_friend(@valid_attrs)
    end

    test "create_user_friend/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_user_friend(@invalid_attrs)
    end

    test "update_user_friend/2 with valid data updates the user_friend" do
      user_friend = user_friend_fixture()
      assert {:ok, %UserFriend{} = user_friend} = Social.update_user_friend(user_friend, @update_attrs)
    end

    test "update_user_friend/2 with invalid data returns error changeset" do
      user_friend = user_friend_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_user_friend(user_friend, @invalid_attrs)
      assert user_friend == Social.get_user_friend!(user_friend.id)
    end

    test "delete_user_friend/1 deletes the user_friend" do
      user_friend = user_friend_fixture()
      assert {:ok, %UserFriend{}} = Social.delete_user_friend(user_friend)
      assert_raise Ecto.NoResultsError, fn -> Social.get_user_friend!(user_friend.id) end
    end

    test "change_user_friend/1 returns a user_friend changeset" do
      user_friend = user_friend_fixture()
      assert %Ecto.Changeset{} = Social.change_user_friend(user_friend)
    end
  end
end
