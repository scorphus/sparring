from itertools import product

with open("day-05.txt") as f:
    lines = f.read().rstrip().splitlines()

diag = {}
overlap =  set()
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
    else:
        diff_x = 1 if x1 < x2 else -1
        diff_y = 1 if y1 < y2 else -1
        for x, y in zip(range(x1, x2 + diff_x, diff_x), range(y1, y2 + diff_y, diff_y)):
            num = diag.get((x, y), 0) + 1
            diag[(x, y)] = num
            if num > 1:
                overlap.add((x, y))
print(len(overlap))
