# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :multiple_products,
  ecto_repos: [MultipleProducts.Repo]

# Configures the endpoint
config :multiple_products, MultipleProductsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/OdT9b64Vo0oNCgr0BU8ralSfoNTfBSd3Oc8+VyGazAqW4Gs3UB/Oa8zRiEnnLyE",
  render_errors: [view: MultipleProductsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MultipleProducts.PubSub,
  live_view: [signing_salt: "41p2oRF0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
