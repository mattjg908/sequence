defmodule Sequence.PopServer do
  use GenServer

  #####
  # External API

  def start_link(initial_list) do
    GenServer.start_link(__MODULE__, initial_list, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(thing) do
    GenServer.cast __MODULE__, {:push, thing}
  end

  def init(initial_list) do
    {:ok, initial_list}
  end

  def handle_call(:pop, _from, [_h|t] = current_list) do
    {:reply, current_list, t}
  end

  def handle_cast({:push, thing}, current_list) do
    {:noreply, [thing|current_list]}
  end

  def terminate(reason, state) do
    IO.puts "Terminate because #{inspect reason}, state at exit #{inspect state}"
  end

end
