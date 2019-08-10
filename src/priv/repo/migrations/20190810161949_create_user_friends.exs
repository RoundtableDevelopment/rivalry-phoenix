defmodule Rivalry.Repo.Migrations.CreateUserFriends do
  use Ecto.Migration

  def change do
    create table(:user_friends) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :friend_id, references(:users, on_delete: :delete_all)
      add :friend_request_id, references(:friend_requests, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:user_friends, [:user_id])
    create index(:user_friends, [:friend_id])
    create index(:user_friends, [:friend_request_id])
  end
end
