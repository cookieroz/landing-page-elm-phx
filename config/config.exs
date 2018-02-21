# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :landing_page,
  ecto_repos: [LandingPage.Repo]

# Configures the endpoint
config :landing_page, LandingPageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pgY1Ex9AxwxHLcYggHTU5hT7dXarloebB0uppM3IHAMWIv52cK/P7afCd1yzqtn3",
  render_errors: [view: LandingPageWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LandingPage.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :landing_page,
  google_recaptcha: [
    secret_key: "6LfOuEcUAAAAAP99V2j_vq3-Qo0Xvkd4XrjmgKjn",
    client: LandingPage.Clients.GoogleRecaptchaHttp
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
