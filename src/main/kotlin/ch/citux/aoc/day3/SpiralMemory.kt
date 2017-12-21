package ch.citux.aoc.day3

import kotlin.math.abs
import kotlin.math.ceil
import kotlin.math.sqrt

fun main(args: Array<String>) {

    val input = 368078
    val spiralMemory = SpiralMemory(input)
    print(spiralMemory.countStepsToCenter(input))
}

data class Coordinate(val x: Int, val y: Int)

class SpiralMemory(maxNumber: Int) {
    private val size: Int
    private val center: Int
    private val index: MutableMap<Int, Coordinate>
    //    private val spiral: Array<IntArray>

    private var number = 1

    init {
        size = calculateSize(maxNumber)
        center = ceil(size / 2f).toInt() - 1
        index = HashMap(maxNumber)
//        spiral = Array(size, { _ -> IntArray(size) })
        fillArray()
    }

    private fun fillArray() {
        addNumber(Coordinate(center, center), number++)
        for (i in 1..center) {
            fillCircle(i)
        }
    }

    private fun fillCircle(distance: Int) {

        val upLeft = center + distance - 1 downTo center - distance
        val downRight = center - distance + 1..center + distance

        upLeft.forEach { i -> addNumber(Coordinate(i, center + distance), number++) }
        upLeft.forEach { i -> addNumber(Coordinate(center - distance, i), number++) }
        downRight.forEach { i -> addNumber(Coordinate(i, center - distance), number++) }
        downRight.forEach { i -> addNumber(Coordinate(center + distance, i), number++) }
    }

    private fun addNumber(coordinate: Coordinate, number: Int) {
//        spiral[coordinates.x][coordinates.y] = number
        index[number] = coordinate
    }

    private fun calculateSize(maxNumber: Int): Int {
        val sqrt = sqrt(maxNumber.toFloat())
        val size = ceil(sqrt).toInt()
        return nexOddNumber(size) // size has to be odd
    }

    private fun nexOddNumber(number: Int): Int {
        return if (number % 2 == 0) number + 1 else number
    }

    private fun manhattan(a: Coordinate?, b: Coordinate?): Int {
        if (a != null && b != null) {
            return abs(a.x - b.y) + abs(a.y - b.x)
        }
        return 0
    }

    fun countStepsToCenter(number: Int): Int {
        return manhattan(index[number], Coordinate(center, center))
    }
}

