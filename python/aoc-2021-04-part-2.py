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
boards_yet_to_win = set(boards)

for number, (b, board) in product(numbers, boards.items()):
    if number not in board or b not in boards_yet_to_win:
        continue
    row, col = board.pop(number)
    boards_rows[b][row].add(number)
    boards_cols[b][col].add(number)
    if len(boards_rows[b][row]) == 5 or len(boards_cols[b][col]) == 5:
        if len(boards_yet_to_win) == 1:
            called_number = number
            break
        boards_yet_to_win.remove(b)
else:
    print("No last winning board found")
    exit(1)

last_board_to_win = boards_yet_to_win.pop()
print(sum(boards[last_board_to_win]) * called_number)
