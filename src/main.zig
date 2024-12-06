const std = @import("std");
const day1 = @import("./day1/day1.zig");
const day2 = @import("./day2/day2.zig");
const day3 = @import("./day3/day3.zig");

pub fn main() !void {
    try day3.main();
}

test {
    std.testing.refAllDecls(@This());
}
