from numpy import cos, deg2rad, pi, sin


def calculate(α):
    # π + αcosα - sinα = π/2  ∴  2αcosα - 2sinα + π = 0
    α = deg2rad(α)
    return 2 * α * cos(α) - 2 * sin(α) + pi


hi = 180
lo = 0
for i in range(100):
    α = lo + (hi - lo) / 2
    res = calculate(α)
    if res == 0:
        break
    elif res < 0:
        hi = α
    else:
        lo = α
    print(f"{i:2d}: {α=: 0.16f} {res=: 0.16f}")

print(f"\n--> {α=: 0.16f} res={calculate(α): 0.16f}")
print(f"--> r={2 * cos(deg2rad(α) / 2): 0.16f}")
