from itertools import product

with open("aoc-2021-05.txt") as f:
    lines = f.read().rstrip().splitlines()

diag = {}
overlap = set()
for fro, to in map(lambda x: x.split(" -> ", 1), lines):
    x1, y1 = map(int, fro.split(",", 1))
    x2, y2 = map(int, to.split(",", 1))
    if x1 == x2 or y1 == y2:
        for x in range(min(x1, x2), max(x1, x2) + 1):
            for y in range(min(y1, y2), max(y1, y2) + 1):
                num = diag.get((x, y), 0) + 1
                diag[(x, y)] = num
                if num > 1:
                    overlap.add((x, y))
print(len(overlap))
