from typing import TypedDict


class Point2D(TypedDict, total=False):
    x: int
    y: int


class Point3D(TypedDict):
    x: int
    y: int
    z: int


p1 = Point2D(x=1, y=2)
print(p1)
p2 = Point2D(x=1)
print(p2)

p3 = Point3D(x=1, y=2, z=3)
print(p3)
p4 = Point3D(x=1, y=2)
print(p4)
