with open("day-10.txt") as f:
    nav_sys = f.read().rstrip().splitlines()

pairs = {
    "}": "{",
    "]": "[",
    ")": "(",
    ">": "<",
}

points = {
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137,
}

score = 0
for line in nav_sys:
    brackets = []
    for char in line:
        if char in pairs:
            if brackets and pairs[char] == brackets[-1]:
                brackets.pop()
            else:
                score += points[char]
                break
        else:
            brackets.append(char)

print(score)
