with open("day-22.txt") as f:
    lines = [line for line in f.read().rstrip().splitlines()]

cubes = set()
area_min, area_max = -50, 50
trans = str.maketrans("xyz,.=", "      ")
for line in lines:
    on_off, *cuboid = line.translate(trans).split()
    x0, x1, y0, y1, z0, z1 = map(int, cuboid)
    for x in range(max(x0, area_min), min(x1, area_max) + 1):
        for y in range(max(y0, area_min), min(y1, area_max) + 1):
            for z in range(max(z0, area_min), min(z1, area_max) + 1):
                if on_off == "on":
                    cubes.add((x, y, z))
                else:
                    cubes.discard((x, y, z))
print(len(cubes))
