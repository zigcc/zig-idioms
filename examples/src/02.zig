const std = @import("std");

const Rect = struct {
    w: usize,
    h: usize,

    fn init(w: usize, h: usize) Rect {
        return .{ .w = w, .h = h };
    }

    fn getArea(self: Rect) usize {
        return self.w * self.h;
    }
};

pub fn main() !void {
    const rect = Rect.init(1, 2);
    std.debug.print("Area of rect is {d}\n", .{rect.getArea()});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var list = std.ArrayList(Rect).init(allocator);
    defer list.deinit();

    try list.append(rect);
    std.debug.print("Len of list is {d}\n", .{list.items.len});
}
