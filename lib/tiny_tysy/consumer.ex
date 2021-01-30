defmodule TinyTysy.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias TinyTysy.Commands, as: Commands
  alias TinyTysy.Prefix, as: Prefix

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, original_msg, _ws_state}) do

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

  def handle_event(_) do
    Nostrum.Api.update_status("Mi Prefix", "t/help", 3)
    :ok
  end
end
