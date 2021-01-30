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
    [prefix_command | rest] = Regex.split(~r<(\s+)>, String.trim(message))
    prefix_command = Regex.split(~r<t/>, prefix_command, include_captures: true)
    tl(prefix_command) ++ rest
  end

  def get_default_prefix(), do: "t/"

end
