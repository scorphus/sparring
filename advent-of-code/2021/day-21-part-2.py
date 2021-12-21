from itertools import product

try:
    from functools import cache
except ImportError:
    from functools import lru_cache

    cache = lru_cache(None)


with open("day-21.txt") as f:
    lines = [line for line in f.read().rstrip().splitlines()]

p1, p2 = [int(line.split()[-1]) - 1 for line in lines]


@cache
def solve(player, other_player, score=0, other_score=0):
    if score >= 21:
        return 1, 0
    if other_score >= 21:
        return 0, 1
    win = lose = 0
    for roll_sum in map(sum, product(range(1, 4), repeat=3)):
        this_player = (player + roll_sum) % 10
        this_score = score + this_player + 1
        lo, wi = solve(other_player, this_player, other_score, this_score)
        win += wi
        lose += lo
    return win, lose


print(max(solve(p1, p2)))
