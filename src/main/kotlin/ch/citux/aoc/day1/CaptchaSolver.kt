package ch.citux.aoc.day1

fun main(args: Array<String>) {
    val captchaSolver = CaptchaSolver()
    val input = captchaSolver.javaClass.getResource("/day1.txt").readText()
    print(CaptchaSolver().solve(input))
}

class CaptchaSolver {
    fun solve(captcha: String): Int {
        val numbers = mapString(captcha)
        var total = 0
        for (i in 0 until numbers.size) {
            val a = numbers[i]
            val j = (i + numbers.size / 2) % numbers.size
            val b = numbers[j]
            if (a == b) {
                total += a
            }

        }
        return total
    }

    fun mapString(input: String): List<Int> {
        val numbers: MutableList<Int> = mutableListOf()
        IntRange(0, input.length - 1).mapTo(numbers) { input.substring(IntRange(it, it)).toInt() }
        return numbers
    }
}