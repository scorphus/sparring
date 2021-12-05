from itertools import product

with open("aoc-2021-04.txt") as f:
    numbers_str, *boards_str = f.read().rstrip().split("\n\n")

numbers = [int(n) for n in numbers_str.split(",")]

boards = {}
for b, board_str in enumerate(boards_str):
    boards[b] = {}
    for r, row in enumerate(board_str.splitlines()):
        for c, number in enumerate(map(int, row.split())):
            boards[b][number] = r, c

boards_rows = [[set() for _ in range(5)] for _ in range(len(boards))]
boards_cols = [[set() for _ in range(5)] for _ in range(len(boards))]

for number, (b, board) in product(numbers, boards.items()):
    if number not in board:
        continue
    row, col = board.pop(number)
    boards_rows[b][row].add(number)
    boards_cols[b][col].add(number)
    if len(boards_rows[b][row]) == 5 or len(boards_cols[b][col]) == 5:
        winning_board = b
        called_number = number
        break
else:
    print("No winning board found")
    exit(1)

print(sum(boards[winning_board]) * called_number)
