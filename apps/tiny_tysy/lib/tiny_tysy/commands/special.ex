defmodule TinyTysy.Commands.Special do
  def tysyak(original_message) do
    embed = %Nostrum.Struct.Embed{
      color: 13_278_919,
      description: wtysyak(1)
    }
    {:ok, tmp_msg} = Nostrum.Api.create_message(original_message.channel_id,
      embed: embed )
    {:ok, old} = NaiveDateTime.from_iso8601(tmp_msg.timestamp)
    :timer.sleep(2_000)
    {:ok, tmp_msg} = Nostrum.Api.edit_message(tmp_msg,
      embed: Nostrum.Struct.Embed.put_description(embed, wtysyak(2)))
    :timer.sleep(2_000)
    {:ok, tmp_msg} = Nostrum.Api.edit_message(tmp_msg,
      embed: Nostrum.Struct.Embed.put_description(embed, wtysyak(3)))
    :timer.sleep(2_000)
    Nostrum.Api.edit_message(tmp_msg,
      embed: Nostrum.Struct.Embed.put_description(embed, wtysyak(4)))
    new = NaiveDateTime.utc_now
    time = Time.diff(new, old)
    fmsg = "#{time}[s]"
    Nostrum.Api.edit_message(tmp_msg,
      embed: embed
      |> Nostrum.Struct.Embed.put_footer(fmsg)
      |> Nostrum.Struct.Embed.put_description(wtysyak(4)))
  end

  defp wtysyak(1) do
    """
    ```elixir
    defmodule Tysyak do
    end
    ```
    """
  end

  defp wtysyak(2) do
    """
    ```elixir
    defmodule Tysyak do
      def tysyak do
      end
    end
    ```
    """
  end

  defp wtysyak(3) do
    """
    ```elixir
    defmodule Tysyak do
      def tysyak do
        :owo
      end
    end
    ```
    """
  end

  defp wtysyak(4) do
    """
    ```elixir
    defmodule Tysyak do
      def tysyak do
        :uwu
      end
    end
    ```
    """
  end

end
