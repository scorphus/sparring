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


def flashers_round(grid, energy_map):
    flashers = energy_map.get(10, deque([]))
    flashed = set(flashers)
    while flashers:
        i, j = flashers.popleft()
        for di, dj in DELTAS:
            ni, nj = i + di, j + dj
            if (ni, nj) in flashed or (ni, nj) not in grid or grid[ni, nj] > 10:
                continue
            energy = grid[ni, nj]
            energy_map[energy].remove((ni, nj))
            grid[ni, nj] += 1
            if energy == 9:
                flashers.append((ni, nj))
                flashed.add((ni, nj))
            elif energy < 9:
                energy_map.setdefault(energy + 1, deque([])).append((ni, nj))
    return flashed


def reset_flashed(flashed, grid):
    for i, j in flashed:
        grid[i, j] = 0


def represent(grid):
    grid_repr = [[" " for _ in range(size)] for _ in range(size)]
    for i, j in grid:
        grid_repr[i][j] = "🐙" if grid[i, j] else "🌟"
    return "\n".join(["".join(row) for row in grid_repr])


size = len(lines)
term_cols, term_lines = os.get_terminal_size()
animate = float(
    next((a.split("=")[1] for a in sys.argv if a.startswith("--animate=")), 0)
)
steps = 0
ans1 = 0
ans2 = 0
while True:
    energy_map = {}
    for (i, j), energy in grid.items():
        energy += 1
        grid[i, j] = energy
        energy_map.setdefault(energy, deque([])).append((i, j))
    flashed = flashers_round(grid, energy_map)
    if steps < 100:
        ans1 += len(flashed)
    reset_flashed(flashed, grid)
    steps += 1
    if animate:
        print(
            "\n" * (term_lines - size + 1)
            + represent(grid)
            + " " * (term_cols - 2 * size),
            end="",
        )
        time.sleep(animate)
    if len(flashed) == size * size:
        ans2 = steps
        break

if animate:
    print()
print("Part 1:", ans1)
print("Part 2:", ans2)
