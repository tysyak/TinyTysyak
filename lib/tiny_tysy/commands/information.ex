defmodule TinyTysy.Commands.Information do
  import Nostrum.Struct.Embed
  use Nostrum.Consumer

  alias Nostrum.Api
  def ping(content_message) do
    embed = %Nostrum.Struct.Embed{
      title: "¡Ping!",
      description: "Calculando...",
      color: 13_278_919
    }
    {:ok, old} = NaiveDateTime.from_iso8601(content_message.timestamp)
    {:ok, message} = Api.create_message(content_message.channel_id,
      content: "<@#{content_message.author.id}>", embed: embed )
    {:ok, new} = NaiveDateTime.from_iso8601(message.timestamp)
    time = Time.diff(new, old, :microsecond)
    {resp, _emsg} = Api.edit_message(message, embed: put_description(embed, "Tomó: `#{time}[ms]`"))
    resp
  end

  def source(content_message) do
    repo_actual = "GitHub"
    url = "https://github.com/tysyak/TinyTysyak"
    embed = %Nostrum.Struct.Embed{
      description: "Código fuente de este bot " <> repo_actual
    }
    |> put_title(repo_actual)
    |> put_url(url)
    |> put_color(13_278_919)
    |> put_thumbnail("https://i.imgur.com/LZWD7bN.jpg")
    |> put_description("Código fuente de este bot " <> repo_actual <> "\n" <> url)
    {resp, _new} = Api.create_message(content_message.channel_id,
      content: "<@#{content_message.author.id}>", embed: embed )
    resp
  end

  def help(content_message) do
    {:ok, dm} = Api.create_dm(content_message.author.id)
    {:ok, message} = Api.create_message(content_message.channel_id,
      content: "<@#{content_message.author.id}>\nDM enviado..." )
    embed = TinyTysy.Utility.Embed.help()
    {resp, _message} = Api.create_message(dm.id, embed: embed)
    spawn(TinyTysy.Utility.Messages, :delete_soft_message_both, [content_message, message])
    resp
  end
end
