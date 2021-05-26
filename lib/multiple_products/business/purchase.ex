defmodule MultipleProducts.Business.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  alias MultipleProducts.Business.{Product,Invoice}

  schema "purchases" do
    field :info, :map
    field :status, :string
    field :price, :float

    belongs_to :product, Product
    belongs_to :invoice, Invoice

    timestamps()
  end

  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:price, :product_id, :invoice_id, :status])
  end

end
