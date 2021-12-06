with open("day-06.txt") as f:
    fish = f.read().rstrip()

fish = list(map(int, fish.split(",")))
days = 80

for d in range(days):
    for i in range(len(fish)):
        fish[i] -= 1
        if fish[i] == -1:
            fish[i] = 6
            fish.append(8)

print(len(fish))
