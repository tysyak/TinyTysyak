defmodule TinyTysy.Utility.Reaction do
  import Nostrum.Api, only: [
    create_reaction: 3
  ]

  @doc"""
  Se añade una reacción a un mensaje mediante su ID.
  reaction[:id_emoji]
  reaction[:name_emoji]
  """
  def add_reaction(original_msg, reaction) do
    emoji = %Nostrum.Struct.Emoji{
      id: reaction[:id],
      name: reaction[:name]
    }

    create_reaction(
      original_msg.channel_id,
      original_msg.id,
      emoji
    )
  end
end
