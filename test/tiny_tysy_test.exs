defmodule TinyTysyTest do
  use ExUnit.Case
  doctest TinyTysy

  test "greets the world" do
    assert TinyTysy.hello() == :world
  end
end
