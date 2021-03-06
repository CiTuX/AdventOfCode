package ch.citux.aoc.util

import java.io.File
import java.util.*

fun printArray(arr: Array<out Any>) {
    var out = Arrays.deepToString(arr)
    out = out.replace(Regex("[\\s\\[](\\d[,\\]])"), { result -> " 0" + result.groupValues[1] })
    out = out.replace("], ", "]\n[")
    out = out.replace("]]", "]")
    out = out.replace("[[", "[")
    print(out)
}

fun openRessource(fileName: String): File {
    return File(Util().javaClass.getResource(fileName).file)
}

class Util