defmodule TinyTysy.Utility.Messages do
  @moduledoc"""
  Modulo que se encargará de la manipulación (CRUD) de lo mensajes
  """
  import Nostrum.Struct.Embed
  use Nostrum.Consumer

  alias Nostrum.Api

  def delete_soft_message_both(owner_msg, bot_msg, time_d\\5_000) do
    :timer.sleep(time_d)
    Nostrum.Api.delete_message(bot_msg)
    Nostrum.Api.delete_message(owner_msg)
  end

  def error_message(original_message, message) do

    embed = %Nostrum.Struct.Embed{
      title: "Mmmmmm...",
      description: message,
      color: 11_981_584,
    }
    {resp, tmp_msg} = Api.create_message(original_message.channel_id,
      content: "<@#{original_message.author.id}>", embed: embed )
    spawn(fn ->
      delete_soft_message_both(original_message, tmp_msg)
    end)
    {:ok, tmp_msg}
  end

  def delete_messages(amount, original_message) do
      embed = %Nostrum.Struct.Embed{
        title: "Eliminando mensajes",
        description: "Eliminando `#{amount}` mensajes...",
        color: 13_278_919
      }

      id_channel = original_message.channel_id
      {:ok, objetives} = Api.get_channel_messages(id_channel, amount)
      {:ok, message} = Api.create_message(original_message.channel_id,
        content: "<@#{original_message.author.id}>", embed: embed )

      {:ok, old} = NaiveDateTime.from_iso8601(message.timestamp)
      for msg <- objetives do
        :timer.sleep(700)
        Api.delete_message(msg)
      end
      new = NaiveDateTime.utc_now
      time = Time.diff(new, old)
      resp = Api.edit_message(
        message,
        embed: put_description(embed, "Tomó: `#{time}[s]` "<>
          "para **#{amount}** mensajes.")
      )
      :timer.sleep(50)
      delete_soft_message_both(original_message, message, 10_000)
      resp
  end

  defp get_channel_id(content) do
    Regex.scan(~r/\d+/, content) |> hd() |> hd()
  end





end
