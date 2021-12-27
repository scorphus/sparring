from itertools import product


with open("day01.txt") as f:
    instructions = f.read().rstrip().split(", ")

x, y = 0, 0
dx, dy = 0, 1
for instr in instructions:
    turn, blocks = instr[0], int(instr[1:])
    if turn == "R":
        dx, dy = dy, -dx
    else:
        dx, dy = -dy, dx
    x += dx * blocks
    y += dy * blocks

print(abs(x) + abs(y))

x, y = 0, 0
dx, dy = 0, 1
seen = set()
for instr in instructions:
    turn, blocks = instr[0], int(instr[1:])
    if turn == "R":
        dx, dy = dy, -dx
    else:
        dx, dy = -dy, dx
    x0, y0 = x, y
    x += dx * blocks
    y += dy * blocks
    x1 = x if dx else x0 + 1
    y1 = y if dy else y0 + 1
    for xi, yi in product(range(x0, x1, dx or 1), range(y0, y1, dy or 1)):
        if (xi, yi) in seen:
            print(abs(xi) + abs(yi))
            break
        seen.add((xi, yi))
    else:
        continue
    break
