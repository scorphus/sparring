const std = @import("std");

pub fn main() void {
    const x = 4;
    switch (x) {
        1 => std.debug.print("one\n", .{}),
        2 => std.debug.print("two\n", .{}),
        3 => std.debug.print("three\n", .{}),
        else => std.debug.print("other ({d})\n", .{x}),
    }
}
