defmodule RailwayTest do
  use ExUnit.Case
  doctest Railway

  test "greets the world" do
    assert Railway.hello() == :world
  end
end
