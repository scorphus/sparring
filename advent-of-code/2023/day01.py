data = open("input01", encoding="utf8").read().strip().splitlines()

solution = 0
for line in data:
    v1 = v2 = 0
    for char in line:
        if char.isdigit():
            v2 = int(char)
            if v1 == 0:
                v1 = v2 * 10
    solution += v1 + v2
print("part one:", solution)

solution = 0
numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
for line in data:
    v1 = v2 = 0
    for i, char in enumerate(line):
        if char.isdigit():
            v2 = int(char)
            if v1 == 0:
                v1 = v2 * 10
        else:
            for j, number in enumerate(numbers, 1):
                if line[i:].startswith(number):
                    v2 = j
                    if v1 == 0:
                        v1 = v2 * 10
                    break
    solution += v1 + v2
print("part two:", solution)
