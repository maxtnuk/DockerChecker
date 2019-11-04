# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :absinthe, adapter: Absinthe.Adapter.LanguageConventions
config :lrmi, :data_pagination,
  limit: 1000

# Configures the endpoint
config :front, FrontWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uiuKvwkr/uymGMJ+khxrrSD29JaGKNf/f7ZrbDCt49mV88hXNe8J8z1tBKQeES5q",
  render_errors: [view: FrontWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Front.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
