defmodule MultipleProducts.Business.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  alias MultipleProducts.Accounts.User
  alias MultipleProducts.Business.Purchase

  schema "invoices" do
    field :stripe, :map
    field :status, :string

    belongs_to :user, User
    has_many :purchases, Purchase

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:stripe, :status, :user_id])
  end

end
