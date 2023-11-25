const std = @import("std");

pub fn build(b: *std.Build) !void {
    var run_all_step = b.step("run-all", "Run all examples");
    inline for (1..4) |num| {
        // This will padding number like 01, 02, .. 99
        const seq = std.fmt.comptimePrint("{d:0>2}", .{num});
        const exe = b.addExecutable(.{
            .name = "examples-" ++ seq,
            .root_source_file = .{ .path = "src/" ++ seq ++ ".zig" },
            .target = .{},
            .optimize = .Debug,
        });

        const run_step = &b.addRunArtifact(exe).step;
        b.step("run-" ++ seq, "Run example " ++ seq).dependOn(run_step);
        run_all_step.dependOn(run_step);
    }
}
