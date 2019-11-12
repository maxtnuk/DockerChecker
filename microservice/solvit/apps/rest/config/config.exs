# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :rest, RestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DRbAxYeYJEIObw8eNmbB8dUrn4K1kvLHdLvO57+lKMzVz9vmekU9bQEcSBb8K/h1",
  render_errors: [view: RestWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Rest.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
