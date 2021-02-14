defmodule TinyTysy.Utility.Messages do
  @moduledoc"""
  Modulo que se encargará de la manipulación (CRUD) de lo mensajes
  """
  import Nostrum.Struct.Embed
  use Nostrum.Consumer

  alias Nostrum.Api

  def write(message, original_message) do
    embed = %Nostrum.Struct.Embed{
      description: message,
      color: 13_278_919
    }
    id_channel = original_message.channel_id
    user =  %Nostrum.Struct.User{id: original_message.author.id}
    Api.create_message(original_message.channel_id, embed: embed )
  end

  def delete_soft_message_both(owner_msg, bot_msg, time_d \\ 5_000) do
    :timer.sleep(time_d)
    Nostrum.Api.delete_message(bot_msg)
    Nostrum.Api.delete_message(owner_msg)
  end

  def error_message(original_message, message) do

    embed = %Nostrum.Struct.Embed{
      title: "Una disculpa..",
      description: message,
      color: 11_981_584,
    }
    user = %Nostrum.Struct.User{id: original_message.author.id}
    {:ok, tmp_msg} = Api.create_message(original_message.channel_id,
      content: "#{Nostrum.Struct.User.mention(user)}", embed: embed )
    spawn(fn ->
      delete_soft_message_both(original_message, tmp_msg)
    end)
    {:ok, tmp_msg}
  end

  def delete_messages(amount, original_message) do
    if amount < 100 do
      embed = %Nostrum.Struct.Embed{
        title: "Eliminando mensajes",
        description: "Eliminando `#{amount}` mensajes...",
        color: 13_278_919
      }

      id_channel = original_message.channel_id
      user =  %Nostrum.Struct.User{id: original_message.author.id}
      {:ok, objetives} = Api.get_channel_messages(id_channel, amount + 1)
      {:ok, message} = Api.create_message(original_message.channel_id,
        content: "#{Nostrum.Struct.User.mention(user)}", embed: embed )

      {:ok, old} = NaiveDateTime.from_iso8601(message.timestamp)
      Api.bulk_delete_messages(id_channel, for(msg <- objetives, do: msg.id))
      new = NaiveDateTime.utc_now
      time = Time.diff(new, old, :microsecond)
      resp = Api.edit_message(
        message,
        embed: put_description(embed, "Tomó: `#{time}[ms]` para **#{amount}** mensajes.")
      )
      :timer.sleep(50)
      delete_soft_message_both(original_message, message, 10_000)
      resp
    else
      {:error, original_message, "Solo puedo procesar menos de **100** mensajes" <>
      " por comando."}
    end
  end
end
