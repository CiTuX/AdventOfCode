package ch.citux.aoc.day1

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertEquals

object CaptchaSolverSpek : Spek({
    given("a captcha solver") {
        val captchaSolver = CaptchaSolver()

        on("1122") {
            val sum = captchaSolver.solve("1122")
            it("produces a sum of 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit.") {
                assertEquals(3, sum)
            }
        }

        on("1111") {
            val sum = captchaSolver.solve("1111")
            it("produces 4 because each digit (all 1) matches the next.") {
                assertEquals(4, sum)
            }
        }

        on("1234") {
            val sum = captchaSolver.solve("123")
            it("produces 0 because no digit matches the next.") {
                assertEquals(0, sum)
            }
        }

        on("91212129") {
            val sum = captchaSolver.solve("91212129")
            it("produces 9 because the only digit that matches the next one is the last digit, 9.") {
                assertEquals(9, sum)
            }
        }
    }
})