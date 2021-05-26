defmodule MultipleProducts.Business do

  import Ecto.Query, warn: false
  alias MultipleProducts.Repo

  alias MultipleProducts.Business.{Product, Invoice, Purchase, Sub}

  # RELATED TO PRODUCTS 
 
  def list_products() do
    Product
    |> Repo.all
  end

  def get_product!(id), do: Repo.get!(Product, id)

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end


  # RELATED TO INVOICE-ITEMS

  def list_purchases() do
    Purchase
    |> Repo.all
  end

  def get_purchase!(id) do
    Purchase
      |> Repo.get!(id)
  end

  def change_purchase(%Purchase{} = purchase, attrs \\ %{}) do
    Purchase.changeset(purchase, attrs)
  end

  # RELATED TO INVOICE

  def list_invoices() do
    Invoice
    |> Repo.all
  end

  def get_invoice!(id) do
    Invoice
      |> preload(:purchases)
      |> Repo.get!(id)
  end

  def change_invoice(%Invoice{} = invoice, attrs \\ %{}) do
    Invoice.changeset(invoice, attrs)
  end

  # NEW FUNCTIONS

  # 1. Returns the only "open" invoice of user

  def get_invoice_user!(id) do
    query = from(i in Invoice, where: i.user_id == ^id and i.status=="open", select: i)
    invoice = Repo.one(query)
    if invoice != nil do
        {:ok, invoice}
    else
      %Invoice{}
      |> Invoice.changeset(%{user_id: id, status: "open"})
      |> Repo.insert()
    end
  end

  def create_purchase(invoice, attrs) do
    attrs = Map.put(attrs, :invoice_id, invoice.id)

    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  def delete_purchase(%Purchase{} = purchase) do
    Repo.delete(purchase)
  end

  def pay_invoice(invoice) do
    invoice
    |> Invoice.changeset(%{status: "paid"})
    |> Repo.update()
    
    from(i in Purchase, where: i.invoice_id == ^invoice.id)
    |> Repo.update_all(set: [status: "paid"])
  end

end
