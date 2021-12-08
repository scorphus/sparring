with open("day-08.txt") as f:
    lines = f.read().rstrip().splitlines()

ans = 0
for line in lines:
    _, output = line.split(" | ")
    for digit in output.split(maxsplit=3):
        ans += len(digit) in (2, 3, 4, 7)

print(ans)
