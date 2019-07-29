defmodule Rivalry.Repo do
  use Ecto.Repo,
    otp_app: :rivalry,
    adapter: Ecto.Adapters.Postgres
end
