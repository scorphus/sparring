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


along, at = folds[0]
if along == "x":
    dots = fold_vertically(dots, at)
    ans = len(dots)
else:
    dots = fold_horizontally(dots, at)
    ans = len(dots)

print(ans)
