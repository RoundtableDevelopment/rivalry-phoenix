defmodule Rivalry.AccountsTest do
  use Rivalry.DataCase

  alias Rivalry.Accounts
  alias Rivalry.Accounts.User

  describe "users" do
    @valid_attrs %{email: "test@example.com", username: "someusername", password: "password"}
    @update_attrs %{email: "test@example.com", username: "someupdatedusername", password: "password"}
    @invalid_attrs %{email: nil, username: nil, password: nil}

    test "list_users/0 returns all users" do
      %User{id: id} = user_fixture()
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "get_user!/1 returns the user with given id" do
      %User{id: id} = user_fixture()
      assert %User{id: ^id} = Accounts.get_user!(id)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "test@example.com"
      assert user.username == "someusername"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "changeset/2 validates username formatting" do
      [valid, invalid1, invalid2] = ["cool_guy69", "b@tm@n", "!@#$!@#$"]

      assert {:ok, user } = Accounts.create_user(%{@valid_attrs | username: valid})
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{@valid_attrs | username: invalid1})
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{@valid_attrs | username: invalid2})
    end

    test "changeset/2 validates email formatting" do
      [valid, invalid1, invalid2] = ["cool_guy69@mail.com", "b@tm@n", "!@#$!@#$.com"]

      assert {:ok, user } = Accounts.create_user(%{@valid_attrs | email: valid})
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{@valid_attrs | email: invalid1})
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{@valid_attrs | email: invalid2})
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "test@example.com"
      assert user.username == "someupdatedusername"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.id == Accounts.get_user!(user.id).id
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

  end

  describe "authenticate_by_email_and_pass/2" do
    @email "user@localhost.com"
    @pass "123456"

    setup do
      {:ok, user: user_fixture(email: @email, password: @pass)}
    end

    test "returns user with correct password", %{user: %User{id: id}} do
      assert {:ok, %User{id: ^id}} = Accounts.authenticate_by_email_and_pass(@email, @pass)
    end

    test "returns unauthorized error with invalid password" do
      assert {:error, :unauthorized} = Accounts.authenticate_by_email_and_pass(@email, "badpass")
    end

    test "returns not found error with no matching user for email" do
      assert {:error, :not_found} = Accounts.authenticate_by_email_and_pass("bademail@localhost.com", @pass)
    end
  end
end
