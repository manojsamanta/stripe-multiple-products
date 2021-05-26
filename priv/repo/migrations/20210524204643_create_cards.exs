defmodule MultipleProducts.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do

    create table(:cards) do
      add :stripe_id, :string, null: false

      add :user_id, references("users",  on_delete: :delete_all), null: false
    end

  end
end
