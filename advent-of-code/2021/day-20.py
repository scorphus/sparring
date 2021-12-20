with open("day-20.txt") as f:
    algo, img_in_str = f.read().rstrip().split("\n\n")

algo = algo.replace("\n", "").replace("#", "1").replace(".", "0")

img_in = set()
for i, row in enumerate(img_in_str.split("\n")):
    for j, cell in enumerate(row):
        if cell == "#":
            img_in.add((i, j))
    img_size = i + 1


def enhance(image, size, row, algo):
    swap_lit = algo[0] == "1" and row % 2 == 1
    lit, not_lit = ("0", "1") if swap_lit else ("1", "0")
    is_lit = "1" if algo[0] == "0" else not_lit  # stupid problem LOL
    new_image = set()
    for i in range(row - 1, row + size + 1):
        for j in range(row - 1, row + size + 1):
            algo_index = calc_index(image, i, j, lit, not_lit)
            if algo[algo_index] == is_lit:
                new_image.add((i, j))
    return new_image, size + 2, row - 1


def calc_index(image, i, j, lit, not_lit):
    bit_array = []
    for di in range(-1, 2):
        for dj in range(-1, 2):
            if (i + di, j + dj) in image:
                bit_array.append(lit)
            else:
                bit_array.append(not_lit)
    return int("".join(bit_array), 2)


def show_image(image, size, row):
    for i in range(row, row + size):
        for j in range(row, row + size):
            if (i, j) in image:
                print("#", end="")
            else:
                print(" ", end="")
        print()


img_in, img_size, row = enhance(img_in, img_size, 0, algo)
img_in, img_size, row = enhance(img_in, img_size, row, algo)
print(len(img_in))

for i in range(48):
    img_in, img_size, row = enhance(img_in, img_size, row, algo)
print(len(img_in))
