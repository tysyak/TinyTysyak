use Mix.Config

config :nostrum,
  token: System.get_env("TOKEN_DISCORD"), # The token of your bot as a string
  num_shards: :auto
