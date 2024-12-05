const std = @import("std");
const expectEqual = std.testing.expectEqual;

fn multiplyNumbers(input: []const u8) usize {
    return input.len;
}

test "part1" {
    const input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
    try expectEqual(161, multiplyNumbers(input));
}
