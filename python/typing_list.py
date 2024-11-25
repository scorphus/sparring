import typing
from typing import List  # Should be flagged by UP035

x: List  # Flagged by UP006
x: typing.List  # Flagged by UP006


def func_1a(some_list: list) -> list:
    return [i * 2 for i in some_list]


def func_1b(some_list: list[int]) -> list[int]:
    return [i * 2 for i in some_list]


def func_2a(some_list: List) -> List:
    return [i * 2 for i in some_list]


def func_2b(some_list: List[int]) -> List[int]:
    return [i * 2 for i in some_list]


print(func_1a(["a", "b", "c"]))
print(func_1b(["a", "b", "c"]))
print(func_2a(["a", "b", "c"]))
print(func_2b(["a", "b", "c"]))


foo: List[int] = [1, 2, 3]
