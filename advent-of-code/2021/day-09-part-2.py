import heapq
from functools import reduce

with open("day-09.txt") as f:
    heatmap = list(map(lambda l: list(map(int, l)), f.read().splitlines()))

starts = []
for i in range(len(heatmap)):
    for j in range(len(heatmap[i])):
        if (
            (i == 0 or heatmap[i][j] < heatmap[i - 1][j])
            and (i == len(heatmap) - 1 or heatmap[i][j] < heatmap[i + 1][j])
            and (j == 0 or heatmap[i][j] < heatmap[i][j - 1])
            and (j == len(heatmap[i]) - 1 or heatmap[i][j] < heatmap[i][j + 1])
        ):
            starts.append((i, j))

sizes = [0, 0, 0]
for start in starts:
    stack = {start}
    seen = {start}
    while stack:
        i, j = stack.pop()
        n = heatmap[i][j]
        for x, y in ((i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)):
            if (
                x >= 0
                and y >= 0
                and x < len(heatmap)
                and y < len(heatmap[i])
                and 9 > heatmap[x][y] > heatmap[i][j]
                and (x, y) not in seen
            ):
                stack.add((x, y))
                seen.add((x, y))
    size = len(seen)
    if size > sizes[0]:
        heapq.heapreplace(sizes, size)

print(reduce(lambda x, y: x * y, sizes))
