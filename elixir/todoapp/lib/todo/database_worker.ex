defmodule Todo.DatabaseWorker do
  use GenServer

  def start(db_folder) do
    IO.puts("Starting database worker in #{db_folder}")
    GenServer.start(__MODULE__, db_folder)
  end

  def store(pid, key, data) do
    GenServer.cast(pid, {:store, key, data})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  @impl GenServer
  def init(db_folder) do
    {:ok, db_folder}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, db_folder) do
    file_name(db_folder, key)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, db_folder}
  end

  @impl GenServer
  def handle_call({:get, key}, _from, db_folder) do
    data =
      case File.read(file_name(db_folder, key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, db_folder}
  end

  defp file_name(db_folder, key) do
    Path.join(db_folder, to_string(key))
  end
end
