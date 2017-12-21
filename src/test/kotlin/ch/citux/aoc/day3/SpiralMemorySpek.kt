package ch.citux.aoc.day3

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertEquals

object SpiralMemorySpek : Spek({
    given("a spiral memory") {
        val spiralMemory = SpiralMemory(1024)

        on("1") {
            val steps = spiralMemory.countStepsToCenter(1)
            it("Data from square 1 is carried 0 steps, since it's at the access port.") {
                assertEquals(0, steps)
            }
        }

        on("12") {
            val steps = spiralMemory.countStepsToCenter(12)
            it("Data from square 12 is carried 3 steps, such as: down, left, left.") {
                assertEquals(3, steps)
            }
        }

        on("23") {
            val steps = spiralMemory.countStepsToCenter(23)
            it("Data from square 23 is carried only 2 steps: up twice.") {
                assertEquals(2, steps)
            }
        }

        on("1024") {
            val steps = spiralMemory.countStepsToCenter(1024)
            it("Data from square 1024 must be carried 31 steps.") {
                assertEquals(31, steps)
            }
        }
    }
})