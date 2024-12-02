const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const parseInt = std.fmt.parseInt;
const tokenizeScalar = std.mem.tokenizeScalar;

const Direction = enum { increasing, decreasing, undefined };
const ProblemDampener = enum { on, off };

pub fn main() !void {
    const input = @embedFile("input.txt");

    const part1 = try countSafeReports(input, .off);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{}\n", .{part1});
}

fn countSafeReports(input: []const u8, _: ProblemDampener) !u32 {
    var result: u32 = 0;

    var lineIterator = tokenizeScalar(u8, input, '\n');
    while (lineIterator.next()) |line| {
        var safe = true;
        var previousLevel: u32 = 0;
        var direction = Direction.undefined;
        var levelIterator = tokenizeScalar(u8, line, ' ');

        while (levelIterator.next()) |level| {
            const currentLevel = try parseInt(u32, level, 10);

            if (previousLevel != 0) {
                var safeDirection = Direction.undefined;

                if (currentLevel >= previousLevel) {
                    safeDirection = .increasing;
                } else if (currentLevel <= previousLevel) {
                    safeDirection = .decreasing;
                }

                safe = checkDirection(&direction, safeDirection, previousLevel, currentLevel);
            }

            if (!safe) break;
            previousLevel = currentLevel;
        }

        if (safe) {
            result += 1;
        }
    }

    return result;
}

fn checkDirection(direction: *Direction, safeDirection: Direction, previous: u32, current: u32) bool {
    if (direction.* == .undefined) {
        direction.* = safeDirection;
        return checkDirection(direction, safeDirection, previous, current);
    }

    if (direction.* == safeDirection) {
        return checkLevelDifference(previous, current);
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
    const result = countSafeReports(exampleInput, .off);

    try expectEqual(2, result);
}

test "example part 2" {
    const result = countSafeReports(exampleInput, .on);

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
