defmodule LockerTest do
  use ExUnit.Case
  doctest Locker

  test "greets the world" do
    assert Locker.hello() == :world
  end
end
