package ch.citux.aoc.day3

import kotlin.math.ceil
import kotlin.math.max
import kotlin.math.min

fun main(args: Array<String>) {

    val input = 368078
    val spiralMemory = SpiralMemory(9)

    var number = 0
    var index = 1
    while (number < input) {
        number = spiralMemory.getValue(index++)
    }
    print(number)
}

data class Coordinate(val x: Int, val y: Int)

class SpiralMemory(maxSize: Int) {
    private val size: Int = maxSize
    private val center: Int
    private val spiral: Array<IntArray>
    private val index: MutableList<Int>

    init {
        center = ceil(size / 2f).toInt() - 1
        spiral = Array(size, { _ -> IntArray(size) })
        index = ArrayList()
        fillArray()
    }

    private fun fillArray() {
        addNumber(Coordinate(center, center), 1)
        for (i in 1..center) {
            fillCircle(i)
        }
    }

    private fun fillCircle(distance: Int) {

        val upLeft = center + distance - 1 downTo center - distance
        val downRight = center - distance + 1..center + distance

        upLeft.forEach { i -> addNumber(Coordinate(i, center + distance)) }
        upLeft.forEach { i -> addNumber(Coordinate(center - distance, i)) }
        downRight.forEach { i -> addNumber(Coordinate(i, center - distance)) }
        downRight.forEach { i -> addNumber(Coordinate(center + distance, i)) }
    }

    private fun addNumber(coordinate: Coordinate, defaultNumber: Int = 0) {
        var number = defaultNumber
        for (x in max(coordinate.x - 1, 0)..min(coordinate.x + 1, size - 1)) {
            for (y in max(coordinate.y - 1, 0)..min(coordinate.y + 1, size - 1)) {
                number += spiral[x][y]
            }
        }
        spiral[coordinate.x][coordinate.y] = number
        index.add(number)
    }

    fun getValue(position: Int): Int {
        return index[position - 1]
    }
}

