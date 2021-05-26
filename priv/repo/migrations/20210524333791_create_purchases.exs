defmodule MultipleProducts.Repo.Migrations.CreatePurchases do

  use Ecto.Migration

  def change do

    create table(:invoices) do
      add :stripe, :jsonb
      add :status, :string

      add :user_id, references("users",  on_delete: :delete_all), null: false

      timestamps()
    end

    create table(:purchases) do
      add :price, :float
      add :info, :jsonb
      add :status, :string

      add :product_id, references("products", on_delete: :delete_all), null: false
      add :invoice_id, references("invoices")

      timestamps()
    end
  end

end
