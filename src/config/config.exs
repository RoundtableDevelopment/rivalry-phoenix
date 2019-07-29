# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rivalry,
  ecto_repos: [Rivalry.Repo]

# Configures the endpoint
config :rivalry, RivalryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2GZ5nuuHUGKlnKIhO2VWII/1tpveORTE7NjQ3Tox3aKX0wcZ5pucYcetDv4h0Au8",
  render_errors: [view: RivalryWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Rivalry.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
