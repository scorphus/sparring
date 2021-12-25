with open("day-25.txt") as f:
    lines = [line for line in f.read().splitlines()]


def parse_herds(lines):
    herd_hor = set()
    herd_ver = set()
    for i, line in enumerate(lines):
        for j, c in enumerate(line):
            if c == ">":
                herd_hor.add((i, j))
            if c == "v":
                herd_ver.add((i, j))
    return herd_hor, herd_ver


def step_hor(herd_hor, herd_ver, cols):
    new_herd = set()
    for i, j in herd_hor:
        jj = (j + 1) % cols
        if (i, jj) not in herd_hor and (i, jj) not in herd_ver:
            new_herd.add((i, jj))
        else:
            new_herd.add((i, j))
    return new_herd


def step_ver(herd_ver, herd_hor, rows):
    new_herd = set()
    for i, j in herd_ver:
        ii = (i + 1) % rows
        if (ii, j) not in herd_ver and (ii, j) not in herd_hor:
            new_herd.add((ii, j))
        else:
            new_herd.add((i, j))
    return new_herd


def step(herd_hor, herd_ver, rows, cols):
    new_herd_hor = step_hor(herd_hor, herd_ver, cols)
    new_herd_ver = step_ver(herd_ver, new_herd_hor, rows)
    not_changed = new_herd_hor == herd_hor and new_herd_ver == herd_ver
    return new_herd_hor, new_herd_ver, not_changed


def repr_herds(herd_hor, herd_ver, rows, cols):
    output = [["."] * cols for _ in range(rows)]
    for i, j in herd_hor:
        output[i][j] = ">"
    for i, j in herd_ver:
        output[i][j] = "v"
    return output


rows = len(lines)
cols = len(lines[0])
herd_hor, herd_ver = parse_herds(lines)

ans = 0
while True:
    herd_hor, herd_ver, not_changed = step(herd_hor, herd_ver, rows, cols)
    ans += 1
    if not_changed:
        herds = repr_herds(herd_hor, herd_ver, rows, cols)
        break

print(ans)
