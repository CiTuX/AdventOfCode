const std = @import("std");
const expectEqual = std.testing.expectEqual;

const Direction = enum { increasing, decreasing, undefined };

fn countSafeReports(input: []const u8) !u32 {
    var result: u32 = 0;

    result += @intCast(input.len);

    return result;
}

const exampleInput =
    \\7 6 4 2 1
    \\1 2 7 8 9
    \\9 7 6 2 1
    \\1 3 2 4 5
    \\8 6 4 4 1
    \\1 3 6 7 9
    \\
;

test "example part 1" {
    const result = countSafeReports(exampleInput);

    try expectEqual(2, result);
}
