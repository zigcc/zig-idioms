pub var a: usize = 1;

b: usize,

const Self = @This();

pub fn inc(self: *Self) void {
    self.b += 1;
}
