defmodule Rivalry.MessagesTest do
  use Rivalry.DataCase

  alias Rivalry.Messages

  describe "shouts" do
    alias Rivalry.Messages.Shout

    @invalid_attrs %{}

    test "send_shout/2 makes a new shout between users" do
      [user1, user2] = [user_fixture(), user_fixture()]
      assert {:ok, %Shout{} = shout} = Messages.send_shout(user1, user2)
      assert shout.sender_id == user1.id
      assert shout.recipient_id == user2.id
    end

    test "list_shouts/0 returns all shouts" do
      shout = shout_fixture()
      assert Messages.list_shouts() == [shout]
    end

    test "get_shout!/1 returns the shout with given id" do
      shout = shout_fixture()
      assert Messages.get_shout!(shout.id) == shout
    end

    test "create_shout/1 with valid data creates a shout" do
      [user1, user2] = [user_fixture(), user_fixture()]
      valid_attrs = %{sender_id: user1.id, recipient_id: user2.id}
      assert {:ok, %Shout{} = shout} = Messages.create_shout(valid_attrs)
      assert shout.sender_id == user1.id
      assert shout.recipient_id == user2.id
    end

    test "create_shout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_shout(@invalid_attrs)
    end
  end
end
