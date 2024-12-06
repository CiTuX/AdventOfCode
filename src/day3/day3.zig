const std = @import("std");
const Allocator = std.mem.Allocator;
const Captures = @import("regex").Captures;
const Regex = @import("regex").Regex;
const eql = std.mem.eql;
const expectEqual = std.testing.expectEqual;
const parseInt = std.fmt.parseInt;
const test_allocator = std.testing.allocator;
const tokenizeSequence = std.mem.tokenizeSequence;

const doDelimiter = "do()";
const dontDelimiter = "don't()";
const mulDelimiter = "mul(";
const mulPattern =
    \\(\d+),(\d+)\)
;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const input = @embedFile("input.txt");
    const part1 = try multiplyNumbers(input, false, allocator);
    const part2 = try multiplyNumbers(input, true, allocator);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n{}\n", .{ part1, part2 });
}

fn multiplyNumbers(input: []const u8, conditionalStatements: bool, allocator: Allocator) !usize {
    var result: usize = 0;

    var mulRegex = try Regex.compile(allocator, mulPattern);
    defer mulRegex.deinit();

    var doIterator = tokenizeSequence(u8, input, doDelimiter);
    while (doIterator.next()) |doToken| {
        var instructionsEnabled = true;
        var dontIterator = tokenizeSequence(u8, doToken, dontDelimiter);

        var firstDont = true;
        while (dontIterator.next()) |dontToken| {
            if (firstDont) firstDont = false else instructionsEnabled = false;
            if (!conditionalStatements or instructionsEnabled) {
                var mulIterator = tokenizeSequence(u8, dontToken, mulDelimiter);
                while (mulIterator.next()) |mulToken| {
                    if (eql(u8, mulToken, doToken)) break; // no mul found
                    result += try mul(&mulRegex, mulToken);
                }
            }
        }
    }

    return result;
}

fn mul(regex: *Regex, token: []const u8) !usize {
    var c = try regex.captures(token[0..@min(8, token.len)]);
    if (c) |captures| {
        defer c.?.deinit();

        var x: usize = 0;
        var y: usize = 0;

        x = try digitAt(captures, 1);
        y = try digitAt(captures, 2);
        return x * y;
    }
    return 0;
}

fn digitAt(captures: Captures, i: usize) !usize {
    return try parseInt(usize, captures.sliceAt(i).?, 10);
}

test "part1" {
    const input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
    try expectEqual(161, multiplyNumbers(input, false, test_allocator));
    try expectEqual(0, multiplyNumbers("mul(4*", false, test_allocator));
    try expectEqual(0, multiplyNumbers("mul(6,9!", false, test_allocator));
    try expectEqual(0, multiplyNumbers("?(12,34)", false, test_allocator));
    try expectEqual(0, multiplyNumbers("mul ( 2 , 4 )", false, test_allocator));
}

test "part2" {
    const input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";
    try expectEqual(48, multiplyNumbers(input, true, test_allocator));
}
