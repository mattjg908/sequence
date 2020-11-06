defmodule Sequence.PopServer do
  use GenServer

  def init(initial_list) do
    { :ok, initial_list }
  end

  def handle_call(:pop, _from, [_h|t] = current_list) do
    {:reply, current_list, t}
  end

  def handle_cast({:push, thing}, current_list) do
    { :noreply, [thing|current_list]}
  end

end
