# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config



config :tiny_tysy, TinyTysy.Repo,
  database: System.get_env("DAPP_DB"),
  username: System.get_env("DUSER_DB"),
  password: System.get_env("DPASSWD_DB"),
  hostname: "localhost"

config :tiny_tysy,
  ecto_repos: [TinyTysy.Repo]

config :nostrum,
  token: System.get_env("TOKEN_DISCORD"),
  num_shards: :auto

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
