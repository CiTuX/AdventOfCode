package ch.citux.aoc.day2

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertEquals

object ChecksumCalculatorSpek : Spek({
    given("a checksum calculator") {
        val checksumCalculator = ChecksumCalculator()

        on("5 9 2 8") {
            val checksum = checksumCalculator.calculateChecksum(5, 9, 2, 8)
            it("In the first row, the only two numbers that evenly divide are 8 and 2; the result of this division is 4.") {
                assertEquals(4, checksum)
            }
        }

        on("9 4 7 3") {
            val checksum = checksumCalculator.calculateChecksum(9, 4, 7, 3)
            it("In the second row, the two numbers are 9 and 3; the result is 3.") {
                assertEquals(3, checksum)
            }
        }

        on("3 8 6 5") {
            val checksum = checksumCalculator.calculateChecksum(3, 8, 6, 5)
            it("In the third row, the result is 2.") {
                assertEquals(2, checksum)
            }
        }

        on("4 + 3 + 2 = 9") {
            val spreadsheet = """
                5 9 2 8
                9 4 7 3
                3 8 6 5
                """
            val checksum = spreadsheet.lines().sumBy { checksumCalculator.calculateChecksum(it) }
            it("In this example, the sum of the results would be 4 + 3 + 2 = 9.") {
                assertEquals(9, checksum)
            }
        }
    }
})