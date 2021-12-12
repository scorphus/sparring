from collections import deque
import os
import sys
import time

with open("day-11.txt") as f:
    lines = list(map(lambda l: list(map(int, l)), f.read().splitlines()))

grid = {}
for i, row in enumerate(lines):
    for j, energy in enumerate(row):
        grid[i, j] = energy


DELTAS = (
    (-1, 0),
    (1, 0),
    (0, -1),
    (0, 1),
    (-1, -1),
    (-1, 1),
    (1, -1),
    (1, 1),
)


def energy_levels(grid):
    flashers = deque([])
    for (i, j), energy in grid.items():
        energy += 1
        grid[i, j] = energy
        if energy == 10:
            flashers.append((i, j))
    return flashers


def flashers_round(grid, flashers):
    flashed = set(flashers)
    while flashers:
        i, j = flashers.popleft()
        for di, dj in DELTAS:
            ni, nj = i + di, j + dj
            if (ni, nj) in flashed or (ni, nj) not in grid:
                continue
            grid[ni, nj] += 1
            if grid[ni, nj] == 10:
                flashers.append((ni, nj))
                flashed.add((ni, nj))
    return flashed


def step(grid):
    flashers = energy_levels(grid)
    return flashers_round(grid, flashers)


def reset_flashed(flashed, grid):
    for i, j in flashed:
        grid[i, j] = 0


def represent(grid):
    grid_repr = [[" " for _ in range(size)] for _ in range(size)]
    for i, j in grid:
        grid_repr[i][j] = "🐙" if grid[i, j] else "🌟"
    return "\n".join(["".join(row) for row in grid_repr])


def do_animation(grid, size, animate):
    cols, lines = os.get_terminal_size()
    print("\n" * (lines - size + 1) + represent(grid) + " " * (cols - 2 * size), end="")
    time.sleep(animate)


size = len(lines)
animate = float(
    next((a.split("=")[1] for a in sys.argv if a.startswith("--animate=")), 0)
)
ans1 = 0
ans2 = 0
steps = 0
while True:
    flashed = step(grid)
    if steps < 100:
        ans1 += len(flashed)
    reset_flashed(flashed, grid)
    steps += 1
    if animate:
        do_animation(grid, size, animate)
    if len(flashed) == size * size:
        ans2 = steps
        break

if animate:
    print()
print("Part 1:", ans1)
print("Part 2:", ans2)
