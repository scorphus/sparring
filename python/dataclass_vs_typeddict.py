from dataclasses import dataclass
from timeit import timeit
from typing import NamedTuple
from typing import TypedDict


def create_a_dataclass():
    @dataclass
    class ExampleClass:
        foo: int
        bar: str
        baz: bool
        qux: float
        flob: list
        gloop: dict
        blop: set
        wibble: tuple
        wobble: bytes
        wibble_wibble: bytearray
        wibble_wobble: memoryview
        wobble_wibble: complex
        wobble_wobble: slice


def create_a_namedtuple():
    class ExampleClass(NamedTuple):
        foo: int
        bar: str
        baz: bool
        qux: float
        flob: list
        gloop: dict
        blop: set
        wibble: tuple
        wobble: bytes
        wibble_wibble: bytearray
        wibble_wobble: memoryview
        wobble_wibble: complex
        wobble_wobble: slice


def create_a_typeddict():
    class ExampleClass(TypedDict):
        foo: int
        bar: str
        baz: bool
        qux: float
        flob: list
        gloop: dict
        blop: set
        wibble: tuple
        wobble: bytes
        wibble_wibble: bytearray
        wibble_wobble: memoryview
        wobble_wibble: complex
        wobble_wobble: slice


def create_a_generic_class():
    class ExampleClass:
        foo: int
        bar: str
        baz: bool
        qux: float
        flob: list
        gloop: dict
        blop: set
        wibble: tuple
        wobble: bytes
        wibble_wibble: bytearray
        wibble_wobble: memoryview
        wobble_wibble: complex
        wobble_wobble: slice

        def __init__(
            self,
            foo: int,
            bar: str,
            baz: bool,
            qux: float,
            flob: list,
            gloop: dict,
            blop: set,
            wibble: tuple,
            wobble: bytes,
            wibble_wibble: bytearray,
            wibble_wobble: memoryview,
            wobble_wibble: complex,
            wobble_wobble: slice,
        ) -> None:
            self.foo = foo
            self.bar = bar
            self.baz = baz
            self.qux = qux
            self.flob = flob
            self.gloop = gloop
            self.blop = blop
            self.wibble = wibble
            self.wobble = wobble
            self.wibble_wibble = wibble_wibble
            self.wibble_wobble = wibble_wobble
            self.wobble_wibble = wobble_wibble
            self.wobble_wobble = wobble_wobble


timeit_dataclass = timeit(
    stmt="create_a_dataclass()",
    setup="from __main__ import create_a_dataclass",
    number=1000,
)
print(f"dataclass: {timeit_dataclass:.2f}s")

timeit_namedtuple = timeit(
    stmt="create_a_namedtuple()",
    setup="from __main__ import create_a_namedtuple",
    number=1000,
)
print(f"namedtuple: {timeit_namedtuple:.2f}s")

timeit_typeddict = timeit(
    stmt="create_a_typeddict()",
    setup="from __main__ import create_a_typeddict",
    number=1000,
)
print(f"typeddict: {timeit_typeddict:.2f}s")

timeit_generic_class = timeit(
    stmt="create_a_generic_class()",
    setup="from __main__ import create_a_generic_class",
    number=1000,
)
print(f"generic class: {timeit_generic_class:.2f}s")

print("= " * 10)

ratio = timeit_dataclass / timeit_namedtuple
print(f"namedtuple is {ratio:.2f} times faster than dataclass")

ratio = timeit_namedtuple / timeit_typeddict
print(f"typeddict is {ratio:.2f} times faster than namedtuple")

ratio = timeit_typeddict / timeit_generic_class
print(f"generic class is {ratio:.2f} times faster than typeddict")
