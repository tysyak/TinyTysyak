defmodule TinyTysy.Consumer do
  use Nostrum.Consumer

  alias TinyTysy.Commands, as: Commands
  alias TinyTysy.Prefix, as: Prefix

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({event, original_msg, _ws_state}) do
    case event do
      :MESSAGE_CREATE -> event_chat(:MESSAGE_CREATE, original_msg)
      :MESSAGE_REACTION_ADD -> IO.inspect :ok
      _ -> :ok
    end
  end

  defp event_chat(:MESSAGE_CREATE, original_msg) do
    command_complete = Prefix.sanitizer_command(original_msg.content)
    cond do
      is_list(command_complete) -> :ok
      :true -> parce_single_cmd(command_complete, original_msg)
    end

  end

  defp parce_single_cmd(command, message) do
    case command do
      "ping" -> Commands.Information.ping(message)
      _ -> :ok
    end
  end


end
