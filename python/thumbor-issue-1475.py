import sys

from PIL import Image, ImageDraw


DELTAS = (
    (-1, 0),
    (1, 0),
    (0, -1),
    (0, 1),
    (-1, -1),
    (1, -1),
    (-1, 1),
    (1, 1),
)
HEIGHT = 36
width = int(sys.argv[1])

with Image.new("RGB", (width, HEIGHT), (255, 255, 255)) as im:
    draw = ImageDraw.Draw(im)
    fill = [(255, 0, 255), (255, 255, 255)]
    for d in range(0, HEIGHT // 2):
        draw.rectangle((d, d, im.size[0] - 1 - d, im.size[1] - 1 - d), fill=fill[d % 2])
    for dx, dy in DELTAS:
        draw.text((4 + dx, 12 + dy), f"{im.size[0]}x{im.size[1]}", fill=(0, 0, 0))
    draw.text((4, 12), f"{im.size[0]}x{im.size[1]}", fill=(255, 255, 255))
    im.save(sys.stdout, "PNG")
