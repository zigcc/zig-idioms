# Zig idioms

This repository collects tips for writing clean, idiomatic Zig code.

Each tips is given an example named after it, which could be run with `zig build run`.

> This could be used as guide for developer with other programming languages background.

## 01. Zig files are structs

> Source: https://ziglang.org/documentation/master/#import

Zig source files are implicitly structs, with a name equal to the file's basename with the extension truncated. `@import` returns the struct type corresponding to the file.

```zig
// Foo.zig
pub var a: usize = 1;

b: usize,

const Self = @This();

pub fn inc(self: *Self) void {
    self.b += 1;
}

// main.zig
const Foo = @import("Foo.zig");

pub fn main() !void {
    const foo = Foo{ .b = 100 };
    std.debug.print("Type of Foo is {any}, foo is {any}\n", .{
        @TypeOf(Foo),
        @TypeOf(foo),
    });
    foo.inc();
    std.debug.print("foo.b = {d}\n", .{foo.b});
}
```

This will output

```text
Type of Foo is type, foo is foo
foo.b = 101
```

## 02. Naming Convention

> Source: https://www.openmymind.net/Zig-Quirks/

In general:

- Functions are `camelCase`
- Types are `PascalCase`
- Variables are `lowercase_with_underscores`

So we know `file_path` is mostly a variable, and `FilePath` is mostly a type.

One exception to those rules is functions that return types. They are `PascalCase`, eg:

```zig
pub fn ArrayList(comptime T: type) type {
    return ArrayListAligned(T, null);
}
```

Normally, file names are `lowercase_with_underscore`. However, files that expose a type directly (like our first example), follow the type naming rule. Thus, the file should be named `Foo.zig`, not `foo.zig`.

## 03. Dot Literals

In Zig `.{ ... }` is everywhere, it can be used to initialize struct/tuple/enum, depending on its context.

```zig
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

    const c: Color = .Red;
    const c2 = .Red;
    std.debug.print("Type of c is {any}\n", .{@TypeOf(c)});
    std.debug.print("Type of c2 is {any}\n", .{@TypeOf(c2)});

    // We can use .{ ... } to construct a tuple of tuples
    // This can be handy when test different inputs of functions.
    inline for (.{
        .{ 1, 1 },
        .{ 2, 4 },
        .{ 3, 9 },
    }) |case| {
        try std.testing.expectEqual(mySquare(case.@"0"), case.@"1");
    }
}
```

This will output

```text
Type of rect is main.Rect
Type of rect2 is struct{comptime w: comptime_int = 1, comptime h: comptime_int = 2}
Type of c is main.Color
Type of c2 is @TypeOf(.enum_literal)
```
