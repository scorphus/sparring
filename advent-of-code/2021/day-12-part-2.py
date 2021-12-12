with open("day-12.txt") as f:
    edges = list(map(lambda line: line.split("-"), f.read().splitlines()))

start = "start"
end = "end"
grid = {}

for a, b in edges:
    if a != end and b != start:
        grid.setdefault(a, set()).add(b)
    if a != start and b != end:
        grid.setdefault(b, set()).add(a)


def count_paths(grid, node, end, seen, seen_2x):
    if node == end:
        yield 1
    else:
        seen[node] = seen.get(node, 0) + 1
        if seen[node] == 2 and node.islower():
            seen_2x.add(node)
        if len(seen_2x) < 2:
            for neigh in grid[node]:
                if seen.get(neigh, 0) < 2 or neigh.isupper():
                    yield from count_paths(grid, neigh, end, seen, seen_2x)
        seen[node] -= 1
        seen_2x.discard(node)


print(sum(count_paths(grid, start, end, dict(), set())))
