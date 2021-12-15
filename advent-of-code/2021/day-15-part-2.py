import heapq

with open("day-15.txt") as f:
    lines = [line for line in f.read().rstrip().splitlines()]

graph = {}
for i, row in enumerate(lines):
    for j, n in enumerate(row):
        graph[i, j] = int(n)

DELTAS = (
    (0, 1),
    (1, 0),
    (-1, 0),
    (0, -1),
)
FACTOR = 5


def get_risk(graph, rows, i, j):
    if 0 <= i < rows * FACTOR and 0 <= j < rows * FACTOR:
        pos = i % rows, j % rows
        return (graph[pos] + i // rows + j // rows) % 9 or 9


def find_lowest_risk(graph, rows, start, end):
    queue = [(0, *start)]
    seen = {start}
    while queue:
        risk, i, j = heapq.heappop(queue)
        if (i, j) == end:
            return risk
        for di, dj in DELTAS:
            ni, nj = i + di, j + dj
            r = get_risk(graph, rows, ni, nj)
            if r is not None and (ni, nj) not in seen:
                seen.add((ni, nj))
                heapq.heappush(queue, (risk + r, ni, nj))


size = len(lines) * FACTOR
end = size - 1, size - 1
risk = find_lowest_risk(graph, len(lines), (0, 0), end)
print(risk)
