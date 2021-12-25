try:
    from functools import cache
except ImportError:
    from functools import lru_cache

    cache = lru_cache(None)

with open("day-24.txt") as f:
    instructions = [line.split(maxsplit=2) for line in f.read().splitlines()]


def register_get(register, key):
    if len(key) > 1 or ord(key) < ord("A"):
        return int(key)
    return register[key]


def add(a, b, register):
    register[a] += register_get(register, b)
    return register


def mul(a, b, register):
    register[a] *= register_get(register, b)
    return register


def div(a, b, register):
    register[a] //= register_get(register, b)
    return register


def mod(a, b, register):
    register[a] %= register_get(register, b)
    return register


def eql(a, b, register):
    register[a] = int(register[a] == register_get(register, b))
    return register


INSTR_MAP = {
    "add": add,
    "mul": mul,
    "div": div,
    "mod": mod,
    "eql": eql,
}


def solve(instructions):
    @cache
    def _solve(instr_idx=0, w=0, x=0, y=0, z=0):
        if instr_idx >= len(instructions) or z > 1e5:
            return [] if z == 0 else None
        instr, *ab = instructions[instr_idx]
        if instr == "inp":
            for w in range(1, 10):
                ws = _solve(instr_idx + 1, w, x, y, z)
                if ws is not None:
                    return [w] + ws
            return
        register = INSTR_MAP[instr](*ab, {"w": w, "x": x, "y": y, "z": z})
        return _solve(instr_idx + 1, **register)

    return _solve()


print("".join(str(c) for c in solve(instructions) or []))
