defmodule TinyTysy.Utility.Embed do
  alias Nostrum.Struct.Embed

  def help do
    embed = %Nostrum.Struct.Embed{}
    |> Embed.put_author("TinyTysy", nil, "https://i.imgur.com/LZWD7bN.jpg")
    |> Embed.put_title("Comandos de TinyTysy")
    |> Embed.put_color(13_278_919)
    |> Embed.put_description(description())
  end

  defp description do
    """
    Por ahora los únicos comandos son
    `t/help`: Este mensaje :closed_book:
    `t/ping`: El tiempo de respuesta de discord al servidor  :ping_pong:
    `t/source`: El código fuente de este Bot :computer:
    `t/purge [cantidad]`: Elimina cuantos mensajes quieras(menos de 100 por camando) :recycle:
    """
  end
  def delete_message_both(owner_msg, bot_msg) do
    :timer.sleep(10_000)
    Nostrum.Api.delete_message(bot_msg)
    Nostrum.Api.delete_message(owner_msg)
  end
end
