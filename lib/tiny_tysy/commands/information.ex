defmodule TinyTysy.Commands.Information do
  import Nostrum.Struct.Embed
  use Nostrum.Consumer

  alias Nostrum.Api
  def ping(content_message) do
    embed = %Nostrum.Struct.Embed{
      title: "¡Ping!",
      description: "Calculando...",
      color: 13278919
    }
    {:ok, old} = NaiveDateTime.from_iso8601(content_message.timestamp)
    {:ok, message} = Api.create_message(content_message.channel_id,
      content: "<@#{content_message.author.id}>", embed: embed )
    {:ok, new} = NaiveDateTime.from_iso8601(message.timestamp)
    time = Time.diff(new, old, :microsecond)
    Api.edit_message(message, embed: put_description(embed, "Tomó: `#{time}[ms]`"))
    :ok
  end

end
