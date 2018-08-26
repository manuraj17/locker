defmodule Locker do
  use Application

  def start(_type, _args) do
    Locker.Supervisor.start_link
    Locker.Registry.start_link
  end
end
