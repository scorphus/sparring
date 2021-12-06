from itertools import islice


def simulate(fish):
    total = sum(fish)
    while True:
        spawn = fish[0]
        for i in range(8):
            fish[i] = fish[i + 1]
        fish[-1] = spawn
        fish[6] += spawn
        total += spawn
        yield total


with open("day-06.txt") as f:
    state = f.read().rstrip()

fish = [0] * 9
for i in map(int, state.split(",")):
    fish[i] += 1

days = 256
sim = simulate(fish)
print(next(islice(sim, days - 1, days)))
print(fish)
