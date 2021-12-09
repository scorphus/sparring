with open("day-09.txt") as f:
    heatmap = list(map(lambda l: list(map(int, l)), f.read().rstrip().splitlines()))

ans = 0
for i in range(len(heatmap)):
    for j in range(len(heatmap[i])):
        if (
            (i == 0 or heatmap[i][j] < heatmap[i - 1][j])
            and (i == len(heatmap) - 1 or heatmap[i][j] < heatmap[i + 1][j])
            and (j == 0 or heatmap[i][j] < heatmap[i][j - 1])
            and (j == len(heatmap[i]) - 1 or heatmap[i][j] < heatmap[i][j + 1])
        ):
            ans += heatmap[i][j] + 1
print(ans)
