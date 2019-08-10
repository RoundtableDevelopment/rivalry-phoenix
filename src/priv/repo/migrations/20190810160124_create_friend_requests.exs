defmodule Rivalry.Repo.Migrations.CreateFriendRequests do
  use Ecto.Migration

  def change do
    create table(:friend_requests) do
      add :status, :string
      add :accepted_at, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all)
      add :friend_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:friend_requests, [:user_id])
    create index(:friend_requests, [:friend_id])
    create unique_index(:friend_requests, [:user_id, :friend_id])
  end
end
