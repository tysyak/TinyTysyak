defmodule TinyTysy.Consumer do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias TinyTysy.Commands, as: Commands
  alias TinyTysy.Prefix, as: Prefix

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, original_msg, _ws_state}) do
    prefix = Prefix.get_default_prefix()
    case Prefix.sanitizer_command(original_msg.content) do
      [prefix, "ping"] -> Commands.Information.ping(original_msg)
      _ ->
        :ok
    end
  end

  def handle_event(_) do
    :ok
  end
end
