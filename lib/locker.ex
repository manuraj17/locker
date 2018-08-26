defmodule Locker do
  use Application

  def start(_type, _args) do
    Locker.Supervisor.start_link
  end
end
