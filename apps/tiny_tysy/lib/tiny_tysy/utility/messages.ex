defmodule TinyTysy.Utility.Messages do
  @moduledoc"""
  Modulo que se encargará de la manipulación (CRUD) de lo mensajes
  """

  def delete_soft_message_both(owner_msg, bot_msg) do
    :timer.sleep(5_000)
    Nostrum.Api.delete_message(bot_msg)
    Nostrum.Api.delete_message(owner_msg)
  end

end
