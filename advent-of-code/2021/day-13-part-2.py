import os
import sys
import time

with open("day-13.txt") as f:
    lines = iter(f.read().rstrip().splitlines())

dots = set()
while line := next(lines):
    x, y = map(int, line.split(","))
    dots.add((x, y))

ans = 0

folds = []
while line := next(lines, ""):
    fold = line.split()[-1].split("=")
    folds.append((fold[0], int(fold[1])))


def fold_horizontally(dots, at):
    new_dots = set()
    for x, y in dots:
        new_dots.add((x, min(y, 2 * at - y)))
    return new_dots


def fold_vertically(dots, at):
    new_dots = set()
    for x, y in dots:
        new_dots.add((min(x, 2 * at - x), y))
    return new_dots


def represent(dots, crop_x=None, crop_y=None):
    max_x = max(x for x, _ in dots)
    max_y = max(y for _, y in dots)
    max_x = min(max_x, crop_x or max_x)
    max_y = min(max_y, crop_y or max_y)
    grid = [["  " for _ in range(max_x + 1)] for _ in range(max_y + 1)]
    for x, y in dots:
        if x <= max_x and y <= max_y:
            grid[y][x] = "██"
    return "\n".join("".join(row) for row in grid), max_x, max_y


def print_grid(dots):
    cols, lines = os.get_terminal_size()
    grid, max_x, max_y = represent(dots, cols // 2 - 2, lines - 1)
    print("\n" * (lines - max_y + 1) + grid + " " * (cols - 2 * max_x - 2), end="")


animate = float(
    next((a.split("=")[1] for a in sys.argv if a.startswith("--animate=")), 0)
)

for i, (along, at) in enumerate(folds):
    if along == "x":
        dots = fold_vertically(dots, at)
    else:
        dots = fold_horizontally(dots, at)
    if animate:
        if i > 0:
            time.sleep(animate)
        print_grid(dots)

if not animate:
    print(represent(dots)[0])
