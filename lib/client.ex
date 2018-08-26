defmodule Locker.Client do
  use GenServer

  # Client API
  def start_link(name, state) do
    GenServer.start_link(Locker.Server, state, name: via_tuple(name))
  end

  def unlock(box_name, password) do
    GenServer.call(via_tuple(box_name), {:unlock, password})
  end

  def reset(box_name, old_password, new_password) do
    GenServer.call(via_tuple(box_name), {:reset, old_password, new_password})
  end

  defp via_tuple(box_name) do
    {:via, :gproc, {:n, :l, {:box_name, box_name}}}
  end
end
