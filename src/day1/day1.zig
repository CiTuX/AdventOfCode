const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const AutoHashMap = std.AutoHashMap;
const GeneralPurposeAllocator = std.heap.GeneralPurposeAllocator;
const asc = std.sort.asc;
const charToDigit = std.fmt.charToDigit;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const sort = std.mem.sort;
const test_allocator = std.testing.allocator;
const testing = std.testing;

const Pair = struct { left: u32, right: u32 };
const char_space = ' ';
const char_eol = '\n';

pub fn main() !void {
    var gpa = GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const input = @embedFile("input.txt");
    var pairs = ArrayList(Pair).init(allocator);
    defer pairs.deinit();

    parseInput(input, &pairs) catch {};

    const part1 = calculateTotalDistance(pairs, allocator);
    const part2 = calculateTotalSimilarity(pairs, allocator);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n{}\n", .{ part1, part2 });
}

fn calculateTotalDistance(pairs: ArrayList(Pair), allocator: Allocator) u32 {
    var result: u32 = 0;
    var lefts = ArrayList(u32).init(allocator);
    var rights = ArrayList(u32).init(allocator);
    defer lefts.deinit();
    defer rights.deinit();

    for (pairs.items) |pair| {
        lefts.append(pair.left) catch {};
        rights.append(pair.right) catch {};
    }

    sortAsc(&lefts) catch {};
    sortAsc(&rights) catch {};

    for (0..lefts.items.len) |i| {
        const left = lefts.items[i];
        const right = rights.items[i];

        result += @max(left, right) - @min(left, right);
    }

    return result;
}

fn calculateTotalSimilarity(pairs: ArrayList(Pair), allocator: Allocator) u32 {
    var result: u32 = 0;
    var similarities = AutoHashMap(u32, u32).init(allocator);
    defer similarities.deinit();

    // count right numbers
    for (pairs.items) |pair| {
        const item = similarities.getOrPut(pair.right) catch {
            return 0;
        };
        if (!item.found_existing) {
            item.value_ptr.* = 0;
        }
        item.value_ptr.* += 1;
    }

    // find similarity for left numbers
    for (pairs.items) |pair| {
        const similarity = similarities.get(pair.left) orelse 0;
        result += @as(u32, pair.left) * similarity;
    }

    return result;
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
                    left[leftIndex] = try charToDigit(value, 10);
                    leftIndex += 1;
                } else {
                    right[rightIndex] = try charToDigit(value, 10);
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

fn joinNumber(number: []const u8) !u32 {
    var result: u32 = 0;
    const len = number.len;

    for (number, 0..) |digit, i| {
        const base = std.math.pow(u32, 10, @intCast(len - i - 1));
        result += base * digit;
    }

    return result;
}

fn sortAsc(list: *ArrayList(u32)) !void {
    sort(u32, list.items, {}, comptime asc(u32));
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

    try expectEqual(11, result);
}

test "example part 2" {
    var pairs = ArrayList(Pair).init(test_allocator);
    defer pairs.deinit();
    parseInput(exampleInput, &pairs) catch {};

    const result = calculateTotalSimilarity(pairs, test_allocator);

    try expectEqual(31, result);
}

test "joinNumber" {
    const number = [_]u8{ 8, 8, 1, 5, 9 };

    const result = joinNumber(number[0..]);

    try expectEqual(88159, result);
}
