defmodule TinyTysy.Repo do
  use Ecto.Repo,
    otp_app: :tiny_tysy,
    adapter: Ecto.Adapters.Postgres
end
