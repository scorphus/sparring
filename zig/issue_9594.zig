const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const reader0 = std.io.fixedBufferStream("1234").reader();

    var buf0: [4]u8 = undefined;
    var foo = reader0.readUntilDelimiter(&buf0, '\n') catch "error";
    print("0->{s}<-\n", .{ foo });
    foo = reader0.readUntilDelimiter(&buf0, '\n') catch |err| @errorName(err);
    print("0->{s}<-\n", .{ foo });
    foo = reader0.readUntilDelimiter(&buf0, '\n') catch |err| @errorName(err);
    print("0->{s}<-\n", .{ foo });

    print("========================\n", .{});

    const reader1 = std.io.fixedBufferStream("000\n1234567\n").reader();

    var buf1: [4]u8 = undefined;
    foo = reader1.readUntilDelimiter(&buf1, '\n') catch "error";
    print("1->{s}<-\n", .{ foo });
    foo = reader1.readUntilDelimiter(&buf1, '\n') catch |err| @errorName(err);
    print("1->{s}<-\n", .{ foo });
    foo = reader1.readUntilDelimiter(&buf1, '\n') catch |err| @errorName(err);
    print("1->{s}<-\n", .{ foo });

    print("========================\n", .{});

    const reader2 = std.io.fixedBufferStream("\n").reader();

    var buf2: [4]u8 = undefined;
    foo = reader2.readUntilDelimiter(&buf2, '\n') catch |err| @errorName(err);
    print("2->{s}<-\n", .{ foo });
    foo = reader2.readUntilDelimiter(&buf2, '\n') catch |err| @errorName(err);
    print("2->{s}<-\n", .{ foo });

    print("========================\n", .{});

    const reader3 = std.io.fixedBufferStream("").reader();

    var buf3: [4]u8 = undefined;
    foo = reader3.readUntilDelimiter(&buf3, '\n') catch |err| @errorName(err);
    print("3->{s}<-\n", .{ foo });
    foo = reader3.readUntilDelimiter(&buf3, '\n') catch |err| @errorName(err);
    print("3->{s}<-\n", .{ foo });
}

test "9594-1" {
    const reader = std.io.fixedBufferStream("1234567\n").reader();

    var buf: [4]u8 = undefined;

    try std.testing.expectError(error.StreamTooLong, reader.readUntilDelimiter(&buf, '\n'));
    try std.testing.expectEqualStrings("567", try reader.readUntilDelimiter(&buf, '\n'));
}

test "9594-4" {
    const reader = std.io.fixedBufferStream("0000\n1234567\n").reader();

    var buf: [4]u8 = undefined;

    try std.testing.expectEqualStrings("0000", try reader.readUntilDelimiter(&buf, '\n'));
    try std.testing.expectError(error.StreamTooLong, reader.readUntilDelimiter(&buf, '\n'));
    try std.testing.expectEqualStrings("567", try reader.readUntilDelimiter(&buf, '\n'));
}

test "9594-5" {
    const reader = std.io.fixedBufferStream("\n").reader();

    var buf: [4]u8 = undefined;

    try std.testing.expectEqualStrings("", try reader.readUntilDelimiter(&buf, '\n'));
    try std.testing.expectError(error.EndOfStream, reader.readUntilDelimiter(&buf, '\n'));
}

test "9594-3" {
    const reader = std.io.fixedBufferStream("1234").reader();

    var buf: [4]u8 = undefined;

    try std.testing.expectError(error.EndOfStream, reader.readUntilDelimiter(&buf, '\n'));
}

test "9594-2" {
    const reader = std.io.fixedBufferStream("123").reader();

    var buf: [4]u8 = undefined;

    try std.testing.expectError(error.EndOfStream, reader.readUntilDelimiter(&buf, '\n'));
}

test "9594-6" {
    const reader = std.io.fixedBufferStream("").reader();

    var buf: [4]u8 = undefined;

    try std.testing.expectError(error.EndOfStream, reader.readUntilDelimiter(&buf, '\n'));
}
