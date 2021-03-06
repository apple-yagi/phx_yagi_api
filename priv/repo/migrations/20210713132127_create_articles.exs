defmodule PhxApp.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string, null: false
      add :content, :text
      add :thumbnail_url, :string
      add :user_id, references(:users, type: :uuid, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:articles, [:user_id])
  end
end
