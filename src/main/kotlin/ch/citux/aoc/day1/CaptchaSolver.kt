package ch.citux.aoc.day1

fun main(args: Array<String>) {
    val captchaSolver = CaptchaSolver()
    val input = captchaSolver.javaClass.getResource("/day1.txt").readText()
    print(CaptchaSolver().solve(input))
}

class CaptchaSolver {
    fun solve(captcha: String): Int {
        val numbers = mapString(captcha)
        var sum = 0
        var total = 0
        var lastNumber = -1
        for (i in IntRange(0, numbers.size)) {
            val number = numbers[if (i == numbers.size) 0 else i]
            if (number == lastNumber) {
                sum += number
            } else {
                total += sum
                sum = 0
            }
            lastNumber = number
        }
        total += sum
        return total
    }

    fun mapString(input: String): List<Int> {
        val numbers: MutableList<Int> = mutableListOf()
        IntRange(0, input.length - 1).mapTo(numbers) { input.substring(IntRange(it, it)).toInt() }
        return numbers
    }
}