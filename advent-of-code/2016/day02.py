with open("day02.txt") as f:
    directions_list = f.read().splitlines()

ans = []
button = 5
for directions in directions_list:
    for direction in directions:
        match direction, button:
            case "U", b if b > 3:
                button = button - 3
            case "D", b if b < 7:
                button = button + 3
            case "L", b if b % 3 != 1:
                button = button - 1
            case "R", b if b % 3 != 0:
                button = button + 1
    ans.append(str(button))

print("".join(ans))

ans = []
button = 5
for directions in directions_list:
    for direction in directions:
        match direction, button:
            case "U", b if b not in {1, 2, 4, 5, 9}:
                button = button - (4 if 4 < button < 13 else 2)
            case "D", b if b not in {5, 9, 10, 12, 13}:
                button = button + (4 if 1 < button < 10 else 2)
            case "L", b if b not in {1, 2, 5, 10, 13}:
                button = button - 1
            case "R", b if b not in {1, 4, 9, 12, 13}:
                button = button + 1
    ans.append(f"{button:X}")

print("".join(ans))
