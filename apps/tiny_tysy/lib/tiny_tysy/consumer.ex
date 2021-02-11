defmodule TinyTysy.Consumer do
  use Nostrum.Consumer

  alias TinyTysy.Commands, as: Commands
  alias TinyTysy.Prefix, as: Prefix

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({event, original_msg, _ws_state}) do
    Nostrum.Api.update_status(:dnd, "En desarrollo UwU OwO")
    case event do
      :MESSAGE_CREATE ->
        event_chat(event, original_msg)
      :MESSAGE_REACTION_ADD -> event_chat(event, original_msg)
      _ -> :ok
    end
  end

  defp event_chat(:MESSAGE_CREATE, original_msg) do
    unless is_nil(original_msg.member) do
      case Prefix.sanitizer_command(original_msg.content) do
        {:ok, command_complete} ->
          cond do
            is_list(command_complete) -> :ok
            :true ->
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
      "" -> {:error, original_msg, "¿Qué quieres que haga?...\nOwO"}
      _ -> {:error, original_msg,
      "El comando \n`#{command}`\n no es de mi dominio"}
    end
  end

  defp val_action(tuple_val) do
    case tuple_val do
      {:ok, _original_msg} -> :ok
      {:error, original_msg, message} ->
        TinyTysy.Utility.Messages.error_message(original_msg, message)
    end
  end
end
