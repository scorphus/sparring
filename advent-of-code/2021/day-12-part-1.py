with open("day-12.txt") as f:
    edges = list(map(lambda line: line.split("-"), f.read().splitlines()))

grid = {}
for a, b in edges:
    grid.setdefault(a, set()).add(b)
    grid.setdefault(b, set()).add(a)


def count_paths(grid, start, end, seen):
    if start == end:
        yield 1
    else:
        seen.add(start)
        for node in grid[start]:
            if node not in seen or node.isupper():
                yield from count_paths(grid, node, end, seen)
        seen.discard(start)


print(sum(count_paths(grid, "start", "end", set())))
