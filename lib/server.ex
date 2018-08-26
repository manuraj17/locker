defmodule Locker.Server do
  use GenServer

  # Server API
  def init(box_name, default_password) do
    :gproc.reg({:n, :l, box_name})
    {:ok, default_password}
  end

  def handle_call({:unlock, password}, _caller, current_password) do
    if current_password == password do
      {:reply, :ok, current_password}
   else
      {:reply, :failed, current_password}
    end
  end

  def handle_call({:reset, old_password, new_password}, _caller, current_password) do
    if current_password == old_password do
      GenServer.cast(self(), {:update, new_password})
      {:reply, :ok, new_password}
    else
      {:reply, :failed, current_password}
    end
  end

  def handle_cast({:update, new_password}, _current_password) do
    {:noreply, new_password}
  end
end
