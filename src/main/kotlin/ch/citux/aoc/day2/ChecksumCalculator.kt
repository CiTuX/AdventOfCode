package ch.citux.aoc.day2

import java.io.File

fun main(args: Array<String>) {
    val captchaSolver = ChecksumCalculator()
    val input = File(captchaSolver.javaClass.getResource("/day2.txt").file)
    print(ChecksumCalculator().checkSpreadsheet(input))
}

class ChecksumCalculator {
    fun checkSpreadsheet(spreadsheet: File): Int {
        var checksum = 0
        spreadsheet.forEachLine { line -> checksum += calculateChecksum(line) }
        return checksum
    }

    fun calculateChecksum(line: String): Int {
        var checksum = 0
        val numbers = mapString(line)
        checksum += calculateChecksum(*numbers.toIntArray())
        return checksum
    }

    fun calculateChecksum(vararg numbers: Int): Int {
        for (a in numbers) {
            for (b in numbers) {
                if (a != b && a % b == 0) {
                    return a / b
                }
            }
        }
        return 0
    }

    private fun mapString(input: String): List<Int> {
        val numbers: MutableList<Int> = mutableListOf()
        if (input.isNotBlank()) {
            input.trim().split('\t', ' ').mapTo(numbers) { number -> number.toInt() }
        }
        return numbers
    }
}