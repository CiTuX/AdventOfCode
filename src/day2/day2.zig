const std = @import("std");
const charToDigit = std.fmt.charToDigit;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const tokenizeScalar = std.mem.tokenizeScalar;

const Direction = enum { increasing, decreasing, undefined };

fn countSafeReports(input: []const u8) !u32 {
    var result: u32 = 0;

    var lineIterator = tokenizeScalar(u8, input, '\n');
    while (lineIterator.next()) |line| {
        var safe = true;
        var previousLevel: u32 = 0;
        var direction = Direction.undefined;
        var levelIterator = tokenizeScalar(u8, line, ' ');

        while (levelIterator.next()) |level| {
            const currentLevel = try charToDigit(level[0], 10);

            if (previousLevel != 0) {
                if (currentLevel >= previousLevel) {
                    safe = checkIncrease(&direction, previousLevel, currentLevel);
                } else if (currentLevel <= previousLevel) {
                    safe = checkDecrease(&direction, previousLevel, currentLevel);
                }
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

fn checkIncrease(direction: *Direction, previous: u32, current: u32) bool {
    switch (direction.*) {
        .undefined => {
            direction.* = .increasing;
            return checkIncrease(direction, previous, current);
        },
        .decreasing => {
            return false;
        },
        .increasing => {
            return checkLevelDifference(previous, current);
        },
    }
}

fn checkDecrease(direction: *Direction, previous: u32, current: u32) bool {
    switch (direction.*) {
        .undefined => {
            direction.* = .decreasing;
            return checkDecrease(direction, previous, current);
        },
        .increasing => {
            return false;
        },
        .decreasing => {
            return checkLevelDifference(previous, current);
        },
    }
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
    const result = countSafeReports(exampleInput);

    try expectEqual(2, result);
}

test "checkLevelDifference" {
    try expect(checkLevelDifference(7, 6));
    try expect(checkLevelDifference(6, 4));
    try expect(!checkLevelDifference(2, 7));
    try expect(!checkLevelDifference(6, 2));
    try expect(!checkLevelDifference(4, 4));
}

test "checkIncrease" {
    var direction = Direction.undefined;
    try expect(checkIncrease(&direction, 6, 4));
    try expectEqual(Direction.increasing, direction);
}

test "checkDecrease" {
    var direction = Direction.undefined;
    try expect(checkDecrease(&direction, 6, 4));
    try expectEqual(Direction.decreasing, direction);
}
