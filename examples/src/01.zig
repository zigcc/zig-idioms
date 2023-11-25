const std = @import("std");
const Foo = @import("Foo.zig");

pub fn main() !void {
    var foo = Foo{ .b = 100 };
    std.debug.print("Type of Foo is {any}, foo is {any}\n", .{
        @TypeOf(Foo),
        @TypeOf(foo),
    });

    foo.inc();
    std.debug.print("foo.b = {d}\n", .{foo.b});
}
