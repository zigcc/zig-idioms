# Zig idioms

This repository collects tips for writing clean, idiomatic Zig code.

Each tips is given an example named after it, which could be run with `zig build run`.

> This could be used as guide for developer with other programming languages background.

## 01. Zig files are structs

> Source: https://ziglang.org/documentation/master/#import

Zig source files are implicitly structs, with a name equal to the file's basename with the extension truncated. `@import` returns the struct type corresponding to the file.

```zig
// foo.zig
pub var a: usize = 1;

b: usize,

// main.zig
const Foo = @import("foo.zig");

pub fn main() !void {
    const foo = Foo{ .b = 100 };
    std.debug.print("Type of Foo is {any}, foo is {any}\n", .{
        @TypeOf(Foo),
        @TypeOf(foo),
    });
}
```

This will output

```
Type of Foo is type, foo is foo
```
