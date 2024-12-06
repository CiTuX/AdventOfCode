const std = @import("std");
const regex = @import("regex");
const Allocator = std.mem.Allocator;
const Captures = regex.Captures;
const Regex = regex.Regex;
const eql = std.mem.eql;
const expectEqual = std.testing.expectEqual;
const parseInt = std.fmt.parseInt;
const test_allocator = std.testing.allocator;

const keyword = "mul(";
const regexPattern =
    \\(\d+),(\d+)\)
;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const input = @embedFile("input.txt");
    const part1 = try multiplyNumbers(input, allocator);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{part1});
}

fn multiplyNumbers(input: []const u8, allocator: Allocator) !usize {
    var result: usize = 0;
    var matcher = try Regex.compile(allocator, regexPattern);
    defer matcher.deinit();

    var iterator = std.mem.tokenizeSequence(u8, input, keyword);

    while (iterator.next()) |token| {
        if (eql(u8, token, input)) break; // no valid mut found

        var c = try matcher.captures(token[0..@min(8, token.len)]);

        if (c) |captures| {
            defer c.?.deinit();

            var x: usize = 0;
            var y: usize = 0;

            x = try digitAt(captures, 1);
            y = try digitAt(captures, 2);

            result += x * y;
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
    try expectEqual(0, multiplyNumbers("mul(4*", test_allocator));
    try expectEqual(0, multiplyNumbers("mul(6,9!", test_allocator));
    try expectEqual(0, multiplyNumbers("?(12,34)", test_allocator));
    try expectEqual(0, multiplyNumbers("mul ( 2 , 4 )", test_allocator));
}

test "part2" {
    const input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";
    try expectEqual(48, multiplyNumbers(input, test_allocator));
}
