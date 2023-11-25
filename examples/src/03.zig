const std = @import("std");

const Rect = struct {
    w: usize,
    h: usize,
};

const Color = enum { Red, Green, Blue };

fn mySquare(x: usize) usize {
    return x * x;
}

pub fn main() !void {
    const rect: Rect = .{ .w = 1, .h = 2 };
    const rect2 = .{ .w = 1, .h = 2 };
    std.debug.print("Type of rect is {any}\n", .{@TypeOf(rect)});
    std.debug.print("Type of rect2 is {any}\n", .{@TypeOf(rect2)});
    // inline for (@typeInfo(@TypeOf(rect)).Struct.fields) |fld| {
    //     std.debug.print("field name:{s}, field:{any}\n", .{ fld.name, fld });
    // }
    // inline for (@typeInfo(@TypeOf(rect2)).Struct.fields) |fld| {
    //     std.debug.print("field name:{s}, field:{any}\n", .{ fld.name, fld });
    // }

    const c: Color = .Red;
    const c2 = .Red;
    std.debug.print("Type of c is {any}\n", .{@TypeOf(c)});
    std.debug.print("Type of c2 is {any}\n", .{@TypeOf(c2)});

    // We can rely on .{ ... } to construct a tuple of tuples
    // This can be handy when testing different inputs of functions.
    inline for (.{
        .{ 1, 1 },
        .{ 2, 4 },
        .{ 3, 9 },
    }) |case| {
        try std.testing.expectEqual(mySquare(case.@"0"), case.@"1");
    }
}
