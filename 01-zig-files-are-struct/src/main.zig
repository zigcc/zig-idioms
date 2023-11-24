const std = @import("std");
const Foo = @import("foo.zig");

pub fn main() !void {
    const foo = Foo{ .b = 100 };
    std.debug.print("Type of Foo is {any}, foo is {any}\n", .{
        @TypeOf(Foo),
        @TypeOf(foo),
    });

    std.debug.print("foo = {any}, Foo.a = {d}, foo.b = {d}\n", .{ foo, Foo.a, foo.b });
}
