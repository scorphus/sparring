from math import cos, pi, radians, sin


def calculate(α):
    # π + αcosα - sinα = π/2  ∴  2αcosα - 2sinα + π = 0
    α = radians(α)
    return 2 * α * cos(α) - 2 * sin(α) + pi


hi = 240
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
print(f"--> r={2 * cos(radians(α) / 2): 0.16f}")


def calculate_area(α):
    # π + αcosα - sinα
    α = radians(α)
    return α * cos(α) - sin(α) + pi



print(f"--> α =   0 => {calculate_area(0): 0.16f}")
print(f"--> α = 180 => {calculate_area(180): 0.16f}")
print(f"--> α =  90 => {calculate_area(90): 0.16f}")
print(f"--> α = 135 => {calculate_area(135): 0.16f}")
