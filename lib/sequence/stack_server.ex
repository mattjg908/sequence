defmodule Sequence.StackServer do
  use GenServer

  #####
  # External API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(thing) do
    GenServer.cast __MODULE__, {:push, thing}
  end

  def init(_) do
    {:ok, Sequence.StackStash.get()}
  end

  def handle_call(:pop, _from, [_h|t] = current_list) do
    {:reply, current_list, t}
  end

  def handle_cast({:push, thing}, current_list) do
    {:noreply, [thing|current_list]}
  end

  def terminate(_reason, current_list) do
    Sequence.StackStash.update(current_list)
  end

end
