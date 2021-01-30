defmodule TinyTysyTest do
  use ExUnit.Case
  doctest TinyTysy

  test "greets the world" do
    assert TinyTysy.hello() == :world
  end

  @test "t/cmd      some"
  @assert ["cmd", "some"]
  test "sanitiser a comand" do
    assert TinyTysy.Prefix.sanitizer_command(@test) == @assert
  end

  @test "t/cmd arg1 arg2"
  @assert ["cmd", "arg1", "arg2"]
  test "sanitiser a comand two args" do
    assert TinyTysy.Prefix.sanitizer_command(@test) == @assert
  end
end
