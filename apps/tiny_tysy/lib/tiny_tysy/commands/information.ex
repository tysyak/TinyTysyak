defmodule TinyTysy.Commands.Information do
  import Nostrum.Struct.Embed
  use Nostrum.Consumer

  alias Nostrum.Api
  def ping(content_message) do
    embed = %Nostrum.Struct.Embed{
      title: "¡Ping!",
      description: "Calculando...",
      color: 13_278_919,
    }
    |> put_footer("Los problemas de la API de Discord podrían"<>
      " generar tiempos de ida y vuelta elevados")

    user = %Nostrum.Struct.User{id: content_message.author.id}

    {:ok, old} = NaiveDateTime.from_iso8601(content_message.timestamp)

    {:ok, message} = Api.create_message(content_message.channel_id,
      content: "#{Nostrum.Struct.User.mention(user)}", embed: embed )

    {:ok, new} = NaiveDateTime.from_iso8601(message.timestamp)

    time = Time.diff(new, old, :microsecond)

    Api.edit_message(
      message,
      embed: put_description(embed, "Tomó: `#{time}[ms]`")
    )
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
    user = %Nostrum.Struct.User{id: content_message.author.id}
    Api.create_message(content_message.channel_id,
      content: "#{Nostrum.Struct.User.mention(user)}", embed: embed )
  end

  def help(content_message) do
    user =  %Nostrum.Struct.User{id: content_message.author.id}
    {:ok, dm} = Api.create_dm(content_message.author.id)
    {:ok, message} = Api.create_message(content_message.channel_id,
      content: "#{Nostrum.Struct.User.mention(user)}\nDM enviado..." )
    embed = TinyTysy.Utility.Embed.help()
    resp = Api.create_message(dm.id, embed: embed)
    spawn(TinyTysy.Utility.Messages, :delete_soft_message_both, [content_message, message])
    resp
  end
end
