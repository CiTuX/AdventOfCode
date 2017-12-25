package ch.citux.aoc.day4

import ch.citux.aoc.input
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
                assertTrue(passphraseChecker.check(input))
            }
        }

        on("aa bb cc dd aa") {
            it(" is not valid - the word aa appears more than once.") {
                assertFalse(passphraseChecker.check(input))
            }
        }

        on("aa bb cc dd aaa") {
            it("  is valid - aa and aaa count as different words.") {
                assertTrue(passphraseChecker.check(input))
            }
        }

        on("abcde fghij") {
            it("  is a valid passphrase.") {
                assertTrue(passphraseChecker.check(input))
            }
        }

        on("abcde xyz ecdab") {
            it("  is not valid - the letters from the third word can be rearranged to form the first word.") {
                assertFalse(passphraseChecker.check(input))
            }
        }

        on("a ab abc abd abf abj") {
            it("   is a valid passphrase, because all letters need to be used when forming another word.") {
                assertTrue(passphraseChecker.check(input))
            }
        }

        on("iiii oiii ooii oooi oooo") {
            it("  is valid.") {
                assertTrue(passphraseChecker.check(input))
            }
        }

        on("oiii ioii iioi iiio") {
            it("  is not valid - any of these words can be rearranged to form any other word..") {
                assertFalse(passphraseChecker.check(input))
            }
        }
    }
})