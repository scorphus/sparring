with open("day-08.txt") as f:
    notes = [line.split(" | ") for line in f.read().rstrip().splitlines()]

patterns = []
outputs = []
for p, o in notes:
    patterns.append([tuple(sorted(s)) for s in p.split(maxsplit=9)])
    outputs.append([tuple(sorted(s)) for s in o.split(maxsplit=3)])


def make_mask(digit):
    mask = 0
    for letter in digit:
        mask |= 1 << (ord(letter) - ord("a"))
    return mask


masks = {}
ans = 0
for pat, out in zip(patterns, outputs):
    for digit in pat:
        mask = make_mask(digit)
        if len(digit) == 2:
            masks[1] = mask
        elif len(digit) == 3:
            masks[7] = mask
        elif len(digit) == 4:
            masks[4] = mask
        elif len(digit) == 7:
            masks[8] = mask
    for i, digit in enumerate(out):
        num = 0
        if len(digit) == 2:
            num = 1
        elif len(digit) == 3:
            num = 7
        elif len(digit) == 4:
            num = 4
        elif len(digit) == 7:
            num = 8
        else:
            mask = make_mask(digit)
            if len(digit) == 5:
                if mask & masks[7] == masks[7]:
                    num = 3
                elif mask | masks[7] | masks[4] == masks[8]:
                    num = 2
                else:
                    num = 5
            else:
                if mask & masks[4] == masks[4]:
                    num = 9
                elif mask & masks[4] & masks[7] != masks[1]:
                    num = 6
        ans += num * 10 ** (3 - i)
print(ans)
