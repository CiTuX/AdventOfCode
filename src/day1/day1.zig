const std = @import("std");
const testing = std.testing;

pub fn main() !void {}

fn calculateTotalDistance(comptime input: []const u8) u64 {
    std.log.debug(input, .{});
    return 0;
}

test "example part 1" {
    const input =
        \\3   4
        \\4   3
        \\2   5
        \\1   3
        \\3   9
        \\3   3
    ;
    const result = calculateTotalDistance(input);
    try std.testing.expectEqual(11, result);
}
