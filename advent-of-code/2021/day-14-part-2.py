from collections import Counter
from itertools import islice

with open("day-14.txt") as f:
    lines = iter(line for line in f.read().rstrip().splitlines() if line)

template = next(lines)
rules = dict(line.split(" -> ") for line in lines)


def insert_elements(insertions, rules):
    new_insertions = {}
    for (a, b), count in insertions.items():
        c = rules[a + b]
        new_insertions[a, c] = new_insertions.get((a, c), 0) + count
        new_insertions[c, b] = new_insertions.get((c, b), 0) + count
    return new_insertions


insertions = {}
for a, b in zip(template, islice(template, 1, None)):
    insertions[a, b] = insertions.get((a, b), 0) + 1

counter = Counter(template)
for _ in range(40):
    insertions = insert_elements(insertions, rules)

counts = {template[-1]: 1}
for (a, b), count in insertions.items():
    counts[a] = counts.get(a, 0) + count

print((max(counts.values()) - min(counts.values())))
