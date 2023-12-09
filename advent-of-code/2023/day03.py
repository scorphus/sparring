data = open("input03", encoding="utf8").read().strip().splitlines()

DIRECTIONS = (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1)


part_numbers = []
gear_part_numbers = {}
for i, row in enumerate(data):
    is_part_number = False
    number = ""
    gears = set()
    for j, cell in enumerate(row):
        if cell.isdigit():
            number += cell
            symbols = [
                ((si, sj), symbol)
                for di, dj in DIRECTIONS
                if 0 <= (si := i + di) < len(data)
                and 0 <= (sj := j + dj) < len(data[si])
                and (symbol := data[si][sj]) != "."
                and not symbol.isdigit()
            ]
            if symbols:
                is_part_number = True
                gears.update(ij for ij, symbol in symbols if symbol == "*")
        if not cell.isdigit() or j == len(row) - 1:
            if is_part_number:
                part_number = int(number)
                part_numbers.append(part_number)
                for gear in gears:
                    gear_part_numbers.setdefault(gear, []).append(part_number)
            is_part_number = False
            number = ""
            gears = set()

print("part one:", sum(part_numbers))
print(
    "part two:",
    sum(
        map(
            lambda pn: pn[0] * pn[1],
            (pn for pn in gear_part_numbers.values() if len(pn) == 2),
        )
    ),
)
for number in part_numbers:
    print(f'"{number}"')
