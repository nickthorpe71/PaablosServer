defmodule PaablosServerTest do
  use ExUnit.Case
  doctest PaablosServer

  test "greets the world" do
    assert PaablosServer.hello() == :world
  end
end
