defmodule TinyTysy.Consumer do
  use Nostrum.Consumer

  alias TinyTysy.Commands, as: Commands
  alias TinyTysy.Prefix, as: Prefix

  @id_dev 580624868341448704

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({event, original_msg, _ws_state}) do
    Nostrum.Api.update_status(:dnd, "En desarrollo UwU OwO")
    case event do
      :MESSAGE_CREATE ->
        :timer.sleep(501)
        event_chat(event, original_msg)
      :MESSAGE_REACTION_ADD -> event_chat(event, original_msg)
      _ -> :ok
    end
  end

  defp event_chat(:MESSAGE_CREATE, original_msg) do
    case Prefix.sanitizer_command(original_msg.content) do
      {:ok, command_complete} ->
        if only_dev(original_msg) do
          if is_list(command_complete) do
            parce_cmd(original_msg, command_complete)
            |> val_action()
          else
            command_complete
            |> parce_single_cmd(original_msg)
            |> val_action()
          end
        _ -> :ok
      end
    end
  end

  defp event_chat(:MESSAGE_REACTION_ADD, original_msg) do
    :ok
  end

  defp parce_single_cmd(command, original_msg) do
    case command do
      "ping" -> Commands.Information.ping(original_msg)
      "source" -> Commands.Information.source original_msg
      "help" -> Commands.Information.help original_msg
      "tysyak" -> Commands.Special.tysyak original_msg
      "" -> {:error, original_msg, "¿Qué quieres que haga?...\nOwO"}
      _ -> {:error, original_msg,
      "El comando \n`#{command}`\n no es de mi dominio"}
    end
  end

  defp parce_cmd(original_msg, [command | arg]) do
    case command do
      "purge" -> arg
      |> hd()
      |> String.to_integer()
      |> TinyTysy.Utility.Messages.delete_messages(original_msg)
       _ -> {:error, original_msg,
           "El comando \n`#{command}`\n no es de mi dominio"}
    end
  end

  defp val_action(tuple_val) do
    case tuple_val do
      {:ok, _original_msg} -> :ok
      {:error, http_error} -> IO.puts "some bad"
      {:error, original_msg, message} ->
        TinyTysy.Utility.Messages.error_message(original_msg, message)
    end
  end

  defp only_dev(original_msg) do
    if original_msg.author.id == @id_dev, do: :true, else: :false
  end
end
