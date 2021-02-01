use Mix.Config

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

# config :tiny_tysy, TinyTysy.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   database: System.get_env("APP_DB"),
#   username: System.get_env("USER_DB"),
#   socket_dir: "/run/postgresql/",
#   pool_size: 10
#   # password: System.get_env("PASSWD_DB"),
