for a in range(2):
    curr_filtered = filter(lambda c: c <= a, range(2))
    for b in curr_filtered:
        print(b)

print("#" * 80)

filters = []
for a in range(2):
    curr_filtered = filter(lambda c: c <= a, range(2))
    filters.append(curr_filtered)

for f in filters:
    for b in f:
        print(b)

print("#" * 80)

filters = []
for a in range(2):
    b = a
    curr_filtered = filter(lambda c: c <= b, range(2))
    filters.append(curr_filtered)

for f in filters:
    for b in f:
        print(b)
