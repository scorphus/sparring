defmodule AStarOrSo do
  def shortest(graph) do
    seen = MapSet.new([{0, 0}])
    queue = :gb_sets.insert({0, {0, 0}}, :gb_sets.empty())
    target = Enum.max(Map.keys(graph))
    recur(graph, seen, queue, target)
  end

  defp recur(graph, seen, queue, target) do
    {{dist, {row, col} = u}, queue} = :gb_sets.take_smallest(queue)

    if u == target do
      dist
    else
      neighbours = [{row - 1, col}, {row + 1, col}, {row, col - 1}, {row, col + 1}]

      {seen, queue} =
        for v <- neighbours,
            Map.has_key?(graph, v),
            not MapSet.member?(seen, v),
            reduce: {seen, queue} do
          {seen, queue} ->
            seen = MapSet.put(seen, v)
            queue = :gb_sets.insert({dist + graph[v], v}, queue)
            {seen, queue}
        end

      recur(graph, seen, queue, target)
    end
  end
end

{:ok, input} = File.read("day-15.txt")
lines = input |> String.split("\n", trim: true)

grid =
  for {line, row} <- Enum.with_index(lines, 0),
      {char, col} <- Enum.with_index(String.to_charlist(line)),
      into: %{} do
    {{row, col}, char - ?0}
  end

AStarOrSo.shortest(grid)
|> IO.puts()

defmodule Grid do
  def expand(grid, n) do
    {height, width} = Enum.max(Map.keys(grid))

    {grid, width, _} =
      for _ <- 2..n, reduce: {grid, width + 1, 1} do
        {grid, offset, bump} ->
          grid =
            for row <- 0..height, col <- 0..width, reduce: grid do
              acc ->
                value = grid[{row, col}] + bump
                value = if value >= 10, do: value - 9, else: value
                Map.put(acc, {row, col + offset}, value)
            end

          {grid, offset + width + 1, bump + 1}
      end

    width = width - 1

    {grid, _, _} =
      for _ <- 2..n, reduce: {grid, height + 1, 1} do
        {grid, offset, bump} ->
          grid =
            for row <- 0..height, col <- 0..width, reduce: grid do
              acc ->
                value = grid[{row, col}] + bump
                value = if value >= 10, do: value - 9, else: value
                Map.put(acc, {row + offset, col}, value)
            end

          {grid, offset + height + 1, bump + 1}
      end

    grid
  end
end

grid
|> Grid.expand(5)
|> AStarOrSo.shortest()
|> IO.puts()
