const std = @import("std");
const ArrayList = std.ArrayList;
const testing = std.testing;
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;
const test_allocator = std.testing.allocator;

const Pair = struct { left: i32, right: i32 };
const char_space = ' ';
const char_eol = '\n';
const ascii_offset = 48;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const input = @embedFile("input.txt");
    var pairs = ArrayList(Pair).init(allocator);
    defer pairs.deinit();

    parseInput(input, &pairs) catch {};

    const result = calculateTotalDistance(pairs, allocator);
    const stdout = std.io.getStdOut().writer();

    try stdout.print("{}", .{result});
}

fn calculateTotalDistance(pairs: ArrayList(Pair), allocator: Allocator) u32 {
    var lefts = ArrayList(i32).init(allocator);
    var rights = ArrayList(i32).init(allocator);
    defer lefts.deinit();
    defer rights.deinit();

    for (pairs.items) |pair| {
        lefts.append(pair.left) catch {};
        rights.append(pair.right) catch {};
    }

    sort(&lefts) catch {};
    sort(&rights) catch {};

    var result: u32 = 0;
    for (0..lefts.items.len) |i| {
        const left = lefts.items[i];
        const right = rights.items[i];

        result += @abs(left - right);
    }

    return result;
}

fn calculateTotalSimilarity(pairs: ArrayList(Pair)) u32 {
    return @intCast(pairs.items.len);
}

fn parseInput(input: []const u8, pairs: *ArrayList(Pair)) !void {
    var left: [5]u8 = undefined;
    var leftIndex: u8 = 0;
    var right: [5]u8 = undefined;
    var rightIndex: u8 = 0;
    var tab: bool = false;

    for (input) |value| {
        switch (value) {
            char_space => {
                tab = true;
                continue;
            },
            char_eol => {
                try addPair(pairs, left[0..leftIndex], right[0..rightIndex]);
                left = undefined;
                leftIndex = 0;
                right = undefined;
                rightIndex = 0;
                tab = false;
            },

            else => {
                if (!tab) {
                    left[leftIndex] = try std.fmt.charToDigit(value, 10);
                    leftIndex += 1;
                } else {
                    right[rightIndex] = try std.fmt.charToDigit(value, 10);
                    rightIndex += 1;
                }
            },
        }
    }
}

fn addPair(pairs: *ArrayList(Pair), left: []const u8, right: []const u8) !void {
    try pairs.append(.{
        .left = try joinNumber(left),
        .right = try joinNumber(right),
    });
}

fn joinNumber(number: []const u8) !i32 {
    var result: i32 = 0;
    const len = number.len;

    for (number, 0..) |digit, i| {
        const base = std.math.pow(i32, 10, @intCast(len - i - 1));
        // std.debug.print("{} {} {}\n", .{ i, base, digit });
        result += base * digit;
    }

    return result;
}

fn sort(list: *ArrayList(i32)) !void {
    std.mem.sort(i32, list.items, {}, comptime std.sort.asc(i32));
}

const exampleInput =
    \\3   4
    \\4   3
    \\2   5
    \\1   3
    \\3   9
    \\3   3
    \\
;

test "example part 1" {
    var pairs = ArrayList(Pair).init(test_allocator);
    defer pairs.deinit();
    parseInput(exampleInput, &pairs) catch {};

    const result = calculateTotalDistance(pairs, test_allocator);

    try std.testing.expectEqual(11, result);
}

test "example part 2" {
    var pairs = ArrayList(Pair).init(test_allocator);
    defer pairs.deinit();
    parseInput(exampleInput, &pairs) catch {};

    const result = calculateTotalSimilarity(pairs);

    try std.testing.expectEqual(31, result);
}

test "joinNumber" {
    const number = [_]u8{ 8, 8, 1, 5, 9 };

    const result = joinNumber(number[0..]);

    try std.testing.expectEqual(88159, result);
}
