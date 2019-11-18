# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config



config :solvit_web,
       generators: [
         context_app: :solvit
       ]

# Configures the endpoint
config :solvit_web,
       SolvitWeb.Endpoint,
       url: [
         host: "localhost"
       ],
       secret_key_base: "VfZtzvTWCs8DWaWtu8USfDXBRl0KLwdgcE3HZjfl66iaWcsJYIrZlty816GgrYra",
       render_errors: [
         view: SolvitWeb.ErrorView,
         accepts: ~w(json)
       ],
       pubsub: [
         name: SolvitWeb.PubSub,
         adapter: Phoenix.PubSub.PG2
       ]

# Configures Elixir's Logger
config :logger,
       :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
