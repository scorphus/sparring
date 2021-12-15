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


def find_lowest_risk(graph, start, end):
    queue = [(0, *start)]
    seen = {start}
    while queue:
        risk, i, j = heapq.heappop(queue)
        if (i, j) == end:
            return risk
        for di, dj in DELTAS:
            ni, nj = i + di, j + dj
            if (ni, nj) in graph and (ni, nj) not in seen:
                seen.add((ni, nj))
                heapq.heappush(queue, (risk + graph[ni, nj], ni, nj))


size = len(lines)
end = size - 1, size - 1
risk = find_lowest_risk(graph, (0, 0), end)
print(risk)
