const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const GeneralPurposeAllocator = std.heap.GeneralPurposeAllocator;
const TokenIterator = std.mem.TokenIterator;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const parseInt = std.fmt.parseInt;
const test_allocator = std.testing.allocator;
const tokenizeScalar = std.mem.tokenizeScalar;

const Direction = enum { increasing, decreasing, undefined };
const ProblemDampener = enum { on, off };

pub fn main() !void {
    var gpa = GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const input = @embedFile("input.txt");
    const part1 = try countSafeReports(input, allocator, .off);
    const part2 = try countSafeReports(input, allocator, .on);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n{}\n", .{ part1, part2 });
}

fn countSafeReports(input: []const u8, allocator: Allocator, problemDampener: ProblemDampener) !u32 {
    var result: u32 = 0;
    var lineIterator = tokenizeScalar(u8, input, '\n');

    while (lineIterator.next()) |line| {
        const safe = try iterateLevels(line, allocator, problemDampener);
        if (safe) result += 1;
    }
    return result;
}

fn iterateLevels(line: []const u8, allocator: Allocator, problemDampener: ProblemDampener) !bool {
    var direction = Direction.undefined;
    var tokenIterator = tokenizeScalar(u8, line, ' ');
    var level = ArrayList(u8).init(allocator);
    defer level.deinit();

    while (tokenIterator.next()) |token| {
        const digit = try parseInt(u8, token, 10);
        try level.append(digit);
    }

    const check = checkLevel(level.items, &direction);
    if (!check and problemDampener == .on) {
        for (0..level.items.len) |i| {
            direction = .undefined;
            var clone = try level.clone();
            defer clone.deinit();

            _ = clone.orderedRemove(i);
            if (checkLevel(clone.items, &direction)) {
                return true;
            }
        }
    }
    return check;
}

fn checkLevel(level: []u8, direction: *Direction) bool {
    var windowIterator = std.mem.window(u8, level, 2, 1);

    while (windowIterator.next()) |window| {
        if (!checkWindow(window[0], window[1], direction)) {
            return false;
        }
    }
    return true;
}

fn checkWindow(current: u32, next: u32, direction: *Direction) bool {
    var safeDirection = Direction.undefined;

    if (current <= next) {
        safeDirection = .increasing;
    } else if (current >= next) {
        safeDirection = .decreasing;
    }

    return checkDirection(direction, safeDirection, current, next);
}

fn checkDirection(direction: *Direction, safeDirection: Direction, x: u32, y: u32) bool {
    if (direction.* == .undefined) {
        direction.* = safeDirection;
        return checkDirection(direction, safeDirection, x, y);
    }

    if (direction.* == safeDirection) {
        return checkLevelDifference(x, y);
    }

    return false;
}

fn checkLevelDifference(x: u32, y: u32) bool {
    const difference = @max(x, y) - @min(x, y);
    return difference >= 1 and difference <= 3;
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
    const result = countSafeReports(exampleInput, test_allocator, .off);

    try expectEqual(2, result);
}

test "example part 2" {
    const result = countSafeReports(exampleInput, test_allocator, .on);

    try expectEqual(4, result);
}

test "checkLevelDifference" {
    try expect(checkLevelDifference(7, 6));
    try expect(checkLevelDifference(6, 4));
    try expect(!checkLevelDifference(2, 7));
    try expect(!checkLevelDifference(6, 2));
    try expect(!checkLevelDifference(4, 4));
}

test "checkDirection increasing" {
    var direction = Direction.undefined;
    try expect(checkDirection(&direction, .increasing, 1, 3));
    try expectEqual(Direction.increasing, direction);
}

test "checkDirection decreasing" {
    var direction = Direction.undefined;
    try expect(checkDirection(&direction, .decreasing, 6, 4));
    try expectEqual(Direction.decreasing, direction);
}
