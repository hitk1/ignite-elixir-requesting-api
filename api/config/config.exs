# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tesla, adapter: Tesla.Adapter.Hackney

config :api,
  ecto_repos: [Api.Repo]

config :api, Api.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :api, Api.Users.Services.Signin,
  issuer: "api",
  secret_key: "F7Vc49ynhvdFNTiQ/bY7Ywjybkp5O6+/VNNWH0mPcvthchb/GD6azIU/gMc++JHr"

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ywi8I6TNRAcBbwK5pOvVsdMVdI4/FLgdMFv7mZ1kP1QLBRF3Adud7wzWagKhRt4v",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Api.PubSub,
  live_view: [signing_salt: "LUugdViC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
