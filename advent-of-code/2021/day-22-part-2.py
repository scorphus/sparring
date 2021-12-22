from bisect import bisect_left
from itertools import product


with open("day-22.txt") as f:
    lines = [line for line in f.read().rstrip().splitlines()]

trans = str.maketrans("xyz,.=", "      ")
ranges = []
xen, yen, zen = [], [], []
for line in lines:
    on_off, *cuboid = line.translate(trans).split()
    x0, x1, y0, y1, z0, z1 = map(int, cuboid)
    x1 += 1
    y1 += 1
    z1 += 1
    ranges.append((1 if on_off == "on" else 0, (x0, x1, y0, y1, z0, z1)))
    xen.extend([x0, x1])
    yen.extend([y0, y1])
    zen.extend([z0, z1])

xen.sort()
yen.sort()
zen.sort()

size = 2 * len(lines)
assert len(xen) == len(yen) == len(zen) == size

cubes = [[[0] * size for _ in range(size)] for _ in range(size)]
for zero_one, (x0, x1, y0, y1, z0, z1) in ranges:
    x0i = bisect_left(xen, x0)
    x1i = bisect_left(xen, x1)
    y0i = bisect_left(yen, y0)
    y1i = bisect_left(yen, y1)
    z0i = bisect_left(zen, z0)
    z1i = bisect_left(zen, z1)
    for x in range(x0i, x1i):
        for y in range(y0i, y1i):
            for z in range(z0i, z1i):
                cubes[x][y][z] = zero_one

ans = 0
for xi, yi, zi in product(range(size - 1), repeat=3):
    ans += (
        cubes[xi][yi][zi]
        * (xen[xi + 1] - xen[xi])
        * (yen[yi + 1] - yen[yi])
        * (zen[zi + 1] - zen[zi])
    )
print(ans)
