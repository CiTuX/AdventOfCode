package ch.citux.aoc.day4

import ch.citux.aoc.util.openRessource
import java.io.File

fun main(args: Array<String>) {
    val input = openRessource("/day4.txt")
    print(PassphraseChecker().checkMany(input))
}

class PassphraseChecker {

    fun checkMany(file: File): Int {
        var counter = 0
        file.forEachLine { passPhrase ->
            if (check(passPhrase)) {
                counter++
            }
        }
        return counter
    }

    fun check(phrase: String): Boolean {
        val wordList = ArrayList<CharSequence>()
        for (word in phrase.splitToSequence(" ")) {
            if (wordList.contains(word)) {
                return false
            }
            wordList.add(word)
        }
        return true
    }
}