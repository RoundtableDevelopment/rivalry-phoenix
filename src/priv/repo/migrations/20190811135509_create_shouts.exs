defmodule Rivalry.Repo.Migrations.CreateShouts do
  use Ecto.Migration

  def change do
    create table(:shouts) do
      add :sender_id, references(:users, on_delete: :nothing), null: false
      add :recipient_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:shouts, [:sender_id])
    create index(:shouts, [:recipient_id])
  end
end
