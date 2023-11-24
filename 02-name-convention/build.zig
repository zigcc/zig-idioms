const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "02-name-convertion",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = .{},
        .optimize = .Debug,
    });

    b.installArtifact(exe);
    b.step("run", "Run").dependOn(&b.addRunArtifact(exe).step);
}
