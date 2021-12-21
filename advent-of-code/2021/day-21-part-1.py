with open("day-21.txt") as f:
    lines = [line for line in f.read().rstrip().splitlines()]

p1, p2 = [int(line.split()[-1]) - 1 for line in lines]


s1 = s2 = 0
roll_sum = 6
while True:
    p1 = (p1 + roll_sum) % 10
    s1 += p1 + 1
    if s1 >= 1000:
        print(s2 * (roll_sum // 3 + 1))
        break
    roll_sum += 9
    p2 = (p2 + roll_sum) % 10
    s2 += p2 + 1
    if s2 >= 1000:
        print(s1 * (roll_sum // 3 + 1))
        break
    roll_sum += 9
