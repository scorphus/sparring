defmodule Todo.Database do
  use GenServer

  @db_folder "./persist"
  @num_workers 3

  def start do
    IO.puts("Starting database server")
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    choose_worker(key)
    |> Todo.DatabaseWorker.store(key, data)
  end

  def get(key) do
    choose_worker(key)
    |> Todo.DatabaseWorker.get(key)
  end

  defp choose_worker(key) do
    GenServer.call(__MODULE__, {:choose_worker, key})
  end

  @impl GenServer
  def init(_) do
    File.mkdir_p!(@db_folder)
    {:ok, start_workers(@num_workers)}
  end

  @impl GenServer
  def handle_call({:choose_worker, key}, _from, workers) do
    worker_key = :erlang.phash2(key, 3)
    {:reply, Map.get(workers, worker_key), workers}
  end

  defp start_workers(n) do
    Stream.map(1..n, &{&1, Todo.DatabaseWorker.start(@db_folder)})
    |> Stream.map(fn {k, {:ok, pid}} -> {k - 1, pid} end)
    |> Map.new()
  end
end
