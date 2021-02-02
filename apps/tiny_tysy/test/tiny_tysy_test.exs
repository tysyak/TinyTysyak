defmodule TinyTysyTest do
  use ExUnit.Case
  doctest TinyTysy

  test "greets the world" do
    assert TinyTysy.hello() == :world
  end

  @test "t/cmd"
  @assert "cmd"
  test "sanitiser a comand withoth args" do
    assert TinyTysy.Prefix.sanitizer_command(@test) == @assert
  end

  @test "t/cmd      some"
  @assert ["cmd", "some"]
  test "sanitiser a comand" do
    assert TinyTysy.Prefix.sanitizer_command(@test) == @assert
  end

  @test "t/cmd arg1 arg2"
  @assert ["cmd", "arg1 arg2"]
  test "sanitiser a comand two args" do
    assert TinyTysy.Prefix.sanitizer_command(@test) == @assert
  end

  # @test ["embed", "{", "\"plainText\":", "\"adsa\",", "\"title\":", "\"s\",",
  #        "\"description\":", "\"s\",", "\"author\":", "{", "\"name\":", "\"sad\",",
  #        "\"icon_url\":", "\"sad\"", "},", "\"color\":", "53380,", "\"footer\":", "{",
  #        "\"text\":", "\"s\",", "\"icon_url\":", "\"s\"", "},", "\"thumbnail\":",
  #        "\"ss\",", "\"image\":", "\"s\"", "}"]
  # @assert "{\"plainText\":\"some plain text\",\"title\":\"title\",\"description\":\"descritption with markdown\",\"author\":{\"name\":\"author\",\"icon_url\":\"aun url\"},\"color\":53380,\"footer\":{\"text\":\"footer text\",\"icon_url\":\"icon url\"},\"thumbnail\":\"a image\",\"image\":\"othe image\"}"
end
