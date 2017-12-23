package ch.citux.aoc.day1

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertEquals

object CaptchaSolverSpek : Spek({
    given("a captcha solver") {
        val captchaSolver = CaptchaSolver()

        on("1212") {
            val sum = captchaSolver.solve("1212")
            it("produces 6: the list contains 4 items, and all four digits match the digit 2 items ahead.") {
                assertEquals(6, sum)
            }
        }

        on("1221") {
            val sum = captchaSolver.solve("1221")
            it("produces 0, because every comparison is between a 1 and a 2.") {
                assertEquals(0, sum)
            }
        }

        on("123425") {
            val sum = captchaSolver.solve("123425")
            it("produces 4, because both 2s match each other, but no other digit has a match.") {
                assertEquals(4, sum)
            }
        }

        on("123123") {
            val sum = captchaSolver.solve("123123")
            it("produces 12.") {
                assertEquals(12, sum)
            }
        }

        on("12131415") {
            val sum = captchaSolver.solve("12131415")
            it("produces 4.") {
                assertEquals(4, sum)
            }
        }
    }
})