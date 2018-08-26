defmodule Locker.Registry do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :registry)
  end

  def whereis_name(box_name) do
    GenServer.call(:registry, {:whereis_name, box_name})
  end

  def register_name(box_name, pid) do
    GenServer.call(:registry, {:register_name, box_name, pid})
  end

  def unregister_name(box_name) do
    GenServer.cast(:registry, {:unregister_name, box_name})
  end

  def send(box_name, message) do
    case whereis_name(box_name) do
      :undefined ->
        {:badarg, {box_name, message}}
      pid -> 
        Kernel.send(pid, message)
        pid
    end
  end

  # Server
  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:whereis_name, box_name}, _from, state) do
    {:reply, Map.get(state, box_name, :undefined), state}
  end

  def handle_call({:register_name, box_name, pid}, _from, state) do
    case Map.get(state, box_name) do
      nil ->
        Process.monitor(pid)
        {:reply, :yes, Map.put(state, box_name, pid)}
      _ -> {:reply, :no, state}
    end
  end

  def handle_cast({:unregister_name, box_name}, state) do
    {:noreply, Map.delete(state, box_name)}
  end

  def handle_info({:DOWN, _, :process, pid, _}, state) do
    {:noreply, remove_pid(state, pid)}
  end

  def remove_pid(state, pid_to_remove) do
    remove = fn {_key, pid} -> pid  != pid_to_remove end
    Enum.filter(state, remove) |> Enum.into(%{})
  end
end
