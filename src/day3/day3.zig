const std = @import("std");
const regex = @import("regex");
const Allocator = std.mem.Allocator;
const Captures = regex.Captures;
const Regex = regex.Regex;
const expectEqual = std.testing.expectEqual;
const parseInt = std.fmt.parseInt;
const test_allocator = std.testing.allocator;

const keyword = "mul";
const regexPattern =
    \\\((\d+),(\d+)\)
;

pub fn main() !void {}

fn multiplyNumbers(input: []const u8, allocator: Allocator) !usize {
    var result: usize = 0;
    var matcher = try Regex.compile(allocator, regexPattern);
    defer matcher.deinit();

    var iterator = std.mem.tokenizeAny(u8, input, keyword);

    while (iterator.next()) |token| {
        var c = try matcher.captures(token);

        if (c) |captures| {
            defer c.?.deinit();
            var i: usize = 1; // skip the first capture
            var x: usize = 0;
            var y: usize = 0;

            while (i < captures.len()) {
                x = try digitAt(captures, i);
                i += 1;
                y = try digitAt(captures, i);
                i += 1;

                result += x * y;
            }
        }
    }

    return result;
}

fn digitAt(captures: Captures, i: usize) !usize {
    return try parseInt(usize, captures.sliceAt(i).?, 10);
}

test "part1" {
    const input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
    try expectEqual(161, multiplyNumbers(input, test_allocator));
}
