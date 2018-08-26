defmodule Locker.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :locker_supervisor)
  end

  def open_box(name, state) do
    Supervisor.start_child(:locker_supervisor, [name, state])
  end

  def init(_) do
    children = [
      worker(Locker.Client, [])
    ]

    supervise(children, [strategy: :simple_one_for_one])
  end
end
