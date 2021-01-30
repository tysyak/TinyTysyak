defmodule TinyTysy.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias TinyTysy.Commands, as: Commands
  alias TinyTysy.Prefix, as: Prefix

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, original_msg, _ws_state}) do
    # IO.inspect Prefix.sanitizer_command(original_msg.content)
    command_complete = Prefix.sanitizer_command(original_msg.content)
    # IO.inspect original_msg.content
    # IO.inspect command_complete
    case command_complete do
      ["ping"] -> Commands.Information.ping(original_msg)
      _ -> :ok
    end
  end

  def handle_event(_) do
    :ok
  end
end
