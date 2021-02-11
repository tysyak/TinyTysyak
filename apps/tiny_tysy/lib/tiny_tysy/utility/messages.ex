defmodule TinyTysy.Utility.Messages do
  @moduledoc"""
  Modulo que se encargará de la manipulación (CRUD) de lo mensajes
  """
  use Nostrum.Consumer

  alias Nostrum.Api

  def delete_soft_message_both(owner_msg, bot_msg) do
    :timer.sleep(5_000)
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

end
