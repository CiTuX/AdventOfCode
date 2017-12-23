package ch.citux.aoc.day4

import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.given
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on
import kotlin.test.assertFalse
import kotlin.test.assertTrue

object PassphraseCheckerSpek : Spek({
    given("a password checker") {
        val passphraseChecker = PassphraseChecker()

        on("aa bb cc dd ee") {
            it(" is valid.") {
                assertTrue(passphraseChecker.check("aa bb cc dd ee"))
            }
        }

        on("aa bb cc dd aa") {
            it(" is not valid - the word aa appears more than once.") {
                assertFalse(passphraseChecker.check("aa bb cc dd aa"))
            }
        }

        on("aa bb cc dd aaa") {
            it("  is valid - aa and aaa count as different words.") {
                assertTrue(passphraseChecker.check("aa bb cc dd aaa"))
            }
        }
    }
})