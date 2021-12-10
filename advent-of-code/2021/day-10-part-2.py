from statistics import median


with open("day-10.txt") as f:
    nav_sys = f.read().rstrip().splitlines()

pairs = {
    ")": "(",
    "]": "[",
    "}": "{",
    ">": "<",
}

points = {
    "(": 1,
    "[": 2,
    "{": 3,
    "<": 4,
}

scores = []
for line in nav_sys:
    brackets = []
    for char in line:
        if char in pairs:
            if brackets and pairs[char] == brackets[-1]:
                brackets.pop()
            else:
                break
        else:
            brackets.append(char)
    else:
        score = 0
        for b in reversed(brackets):
            score = score * 5 + points[b]
        scores.append(score)

print(median(scores))
