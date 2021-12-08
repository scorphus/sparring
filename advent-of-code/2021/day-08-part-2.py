from functools import cache
from itertools import permutations


@cache
def generate_digits(a, b, c, d, e, f, g):
    digits = {
        0: (a, b, c, e, f, g),
        1: (c, f),
        2: (a, c, d, e, g),
        3: (a, c, d, f, g),
        4: (b, c, d, f),
        5: (a, b, d, f, g),
        6: (a, b, d, e, f, g),
        7: (a, c, f),
        8: (a, b, c, d, e, f, g),
        9: (a, b, c, d, f, g),
    }
    return {tuple(sorted(d)): v for v, d in digits.items()}


with open("day-08.txt") as f:
    notes = [line.split(" | ") for line in f.read().rstrip().splitlines()]

patterns = []
outputs = []
for p, o in notes:
    patterns.append([tuple(sorted(s)) for s in p.split(maxsplit=9)])
    outputs.append([tuple(sorted(s)) for s in o.split(maxsplit=3)])

ans = 0
for pat, out in zip(patterns, outputs):
    for perm in permutations("abcdefg"):
        digits = generate_digits(*perm)
        if all(p in digits for p in pat):
            ans += sum(digits[d] * 10 ** (3 - i) for i, d in enumerate(out))
            break

print(ans)
