defmodule TinyTysy.Consumer do
  use Nostrum.Consumer
  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE,original_msg, _ws_state}) do

    case original_msg.content do
      "!ping" ->
        old = original_msg.timestamp
        {:ok, message} = Api.create_message(original_msg.channel_id, "Pong")
        # time = Time.diff(message.timestamp, old)
        Api.edit_message(message, message.content <> "\n tomó [ms]")
      _ ->
        IO.inspect(original_msg)
        :ok
    end
  end

  def handle_event(_) do
    :ok
  end
end
