from collections import Counter
from itertools import islice

with open("day-14.txt") as f:
    lines = iter(line for line in f.read().rstrip().splitlines() if line)

template = next(lines)
rules = dict(line.split(" -> ") for line in lines)


def insert_elements(template, rules):
    new_polymer = []
    for a, b in zip(template, islice(template, 1, None)):
        new_polymer.extend([a, rules[a + b]])
    return "".join(new_polymer + [b])


for _ in range(10):
    template = insert_elements(template, rules)
counts = Counter(template).values()
print(max(counts) - min(counts))
