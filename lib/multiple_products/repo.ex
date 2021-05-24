defmodule MultipleProducts.Repo do
  use Ecto.Repo,
    otp_app: :multiple_products,
    adapter: Ecto.Adapters.Postgres
end
