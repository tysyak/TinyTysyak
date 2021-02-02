defmodule TinyTysy.Prefix do
  @moduledoc """
  Este modulo se encarga de obtener prefijos y de sanar los comandos
  recibidos.
  """

  @doc """
  Recibe el mensaje a analizar, lo limpia qutando los espacios y poniendolos
  en una lista
  """
  def sanitizer_command(message) do
    if Regex.match?(gen_val_regex(), message) do
      [_ | pre_args] = gen_val_regex()
      |> Regex.split(message)
      [pre_args | _] = for x <- pre_args, do: Regex.split(~r/\s+/, String.trim(x))
      [cmd | more_args] = pre_args
      if more_args == [], do: cmd, else: [cmd | [list_str(more_args)]]
    end
  end

  defp gen_val_regex() do
    prefixes = List.to_string(for x <- get_list_default_prefix(), do: x <> "|")
    |> String.slice(0..-2)
    {:ok, regex} = Regex.compile "^(#{prefixes})( +)?"
    regex
  end

  @doc"""
  Esta Funcion manda los dos prefijos por defecto para que se pasen por
  una expreción regular
  """
  def get_list_default_prefix(), do: [
    "t/",
    "<@&804412783068315669>",
    "<@!804411121410768897>"
  ]

  defp list_str([]), do: ""
  defp list_str([one]), do: one
  defp list_str([one, two]), do: "#{ one } #{ two }"
  defp list_str(inp_list) do
    [last | base_list] = Enum.reverse(inp_list)
    base_str  = base_list
    |> Enum.reverse()
    |> Enum.join(" ")

    "#{ base_str }  #{ last }"
  end

end
