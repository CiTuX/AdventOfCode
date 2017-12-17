package ch.citux.aoc.day2

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertEquals

object ChecksumCalculatorSpek : Spek({
    given("a checksum calculator") {
        val checksumCalculator = ChecksumCalculator()

        on("5 1 9 5") {
            val checksum = checksumCalculator.calculateChecksum(5, 1, 9, 5)
            it("The first row's largest and smallest values are 9 and 1, and their difference is 8.") {
                assertEquals(8, checksum)
            }
        }

        on("7 5 3") {
            val checksum = checksumCalculator.calculateChecksum(7, 5, 3)
            it("The second row's largest and smallest values are 7 and 3, and their difference is 4.") {
                assertEquals(4, checksum)
            }
        }

        on("2 4 6 8") {
            val checksum = checksumCalculator.calculateChecksum(2, 4, 6, 8)
            it("The third row's difference is 6.") {
                assertEquals(6, checksum)
            }
        }

        on("8 + 4 + 6 = 18") {
            val spreadsheet = """
                5 1 9 5
                7 5 3
                2 4 6 8
                """
            val checksum = spreadsheet.lines().sumBy { checksumCalculator.calculateChecksum(it) }
            it("In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18.") {
                assertEquals(18, checksum)
            }
        }
    }
})