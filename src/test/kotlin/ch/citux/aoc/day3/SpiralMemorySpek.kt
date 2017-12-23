package ch.citux.aoc.day3

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertEquals

object SpiralMemorySpek : Spek({
    given("a spiral memory") {
        val spiralMemory = SpiralMemory(3)

        on("1") {
            val steps = spiralMemory.getValue(1)
            it("Square 1 starts with the value 1.") {
                assertEquals(1, steps)
            }
        }

        on("2") {
            val steps = spiralMemory.getValue(2)
            it("Square 2 has only one adjacent filled square (with value 1), so it also stores 1.") {
                assertEquals(1, steps)
            }
        }

        on("3") {
            val steps = spiralMemory.getValue(3)
            it("Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.") {
                assertEquals(2, steps)
            }
        }

        on("4") {
            val steps = spiralMemory.getValue(4)
            it("Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.") {
                assertEquals(4, steps)
            }
        }

        on("5") {
            val steps = spiralMemory.getValue(5)
            it("Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.") {
                assertEquals(5, steps)
            }
        }
    }
})