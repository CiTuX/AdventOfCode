const std = @import("std");
const ArrayList = std.ArrayList;
const testing = std.testing;
const expect = std.testing.expect;
const test_allocator = std.testing.allocator;

const Pair = struct { left: u8, right: u8 };
const char_space = ' ';
const char_eol = '\n';
const ascii_offset = 48;

pub fn main() !void {}

fn calculateTotalDistance(input: []const u8) u32 {
    var pairs = ArrayList(Pair).init(test_allocator);
    defer pairs.deinit();

    parseInput(input, &pairs) catch {
        return 0;
    };

    var lefts = ArrayList(u8).init(test_allocator);
    var rights = ArrayList(u8).init(test_allocator);
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
        const left = @as(i16, lefts.items[i]);
        const right = @as(i16, rights.items[i]);

        result += @abs(left - right);
    }

    return result;
}

fn parseInput(input: []const u8, pairs: *ArrayList(Pair)) !void {
    var left: u8 = 0;
    var right: u8 = 0;
    var tab: bool = false;

    for (input) |value| {
        switch (value) {
            char_space => {
                tab = true;
                continue;
            },
            char_eol => {
                try addPair(pairs, left, right);
                left = 0;
                right = 0;
                tab = false;
            },
            else => {
                if (!tab) {
                    left = value - ascii_offset;
                } else {
                    right = value - ascii_offset;
                }
            },
        }
    }
    try addPair(pairs, left, right);
}

fn addPair(pairs: *ArrayList(Pair), left: u8, right: u8) !void {
    try pairs.append(.{
        .left = left,
        .right = right,
    });
}

fn sort(list: *ArrayList(u8)) !void {
    std.mem.sort(u8, list.items, {}, comptime std.sort.asc(u8));
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
