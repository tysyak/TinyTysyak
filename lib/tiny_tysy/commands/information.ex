defmodule TinyTysy.Commands.Information do
  use Nostrum.Consumer

  alias Nostrum.Api
  def ping(content_message) do
    {:ok, old} = NaiveDateTime.from_iso8601(content_message.timestamp)
    {:ok, message} = Api.create_message(content_message.channel_id, "Pong")
    {:ok, new} = NaiveDateTime.from_iso8601(message.timestamp)
    time = Time.diff(new, old, :microsecond)
    Api.edit_message(message, message.content <> "\n`tomó #{time} microsegundos`")
    :ok
  end

end
