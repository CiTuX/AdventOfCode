package ch.citux.aoc.day25

import ch.citux.aoc.util.openRessource
import java.util.*

fun main(args: Array<String>) {
    TuringMachine(openRessource("/day25.txt").readText())
}

class TuringMachine(input: String) {

    private val tape = TreeMap<Int, Int>()
    private val maxSteps: Int
    private val firstState: String
    private val states = HashMap<String, State>()

    private var step = 0
    private var pointer = 0

    companion object {
        val REG_BEGIN = Regex("Begin in state (\\w).")
        val REG_STEPS = Regex("Perform a diagnostic checksum after (\\d+) steps.")
        val REG_STATE = Regex("In state (\\w):")
        val REG_VALUE = Regex("If the current value is (\\d+):")
        val REG_WRITE = Regex("- Write the value (\\d+).")
        val REG_MOVE = Regex("- Move one slot to the (right|left).")
        val REG_NEXT = Regex("- Continue with state (\\w).")
    }

    private class State(val actions: MutableMap<Int, Action>)
    private class Action(val nextState: String, val functions: MutableList<() -> Unit>)

    init {
        val lines = input.lines()

        firstState = getMatch(REG_BEGIN, lines[0])
        maxSteps = getMatch(REG_STEPS, lines[1]).toInt()

        val stateIndex = HashMap<String, MutableList<String>>()

        var name = ""
        for (line in lines) {
            if (REG_STATE.matches(line)) {
                name = getMatch(REG_STATE, line)
                stateIndex[name] = mutableListOf()
            }
            stateIndex[name]?.add(line)
        }

        for (entry in stateIndex) {
            states[entry.key] = parseState(entry.value)
        }

        start()
        print(checksum())
    }

    private fun parseState(lines: List<String>): State {
        val actions = mutableMapOf<Int, Action>()
        var functions = mutableListOf<() -> Unit>()
        var condition = -1

        for (line in lines) {
            val current = getMatch(REG_VALUE, line)
            if (current.isNotEmpty()) {
                condition = current.toInt()
                functions = mutableListOf()
                continue
            }

            val write = getMatch(REG_WRITE, line)
            if (write.isNotEmpty()) {
                functions.add({ set(pointer, write.toInt()) })
                continue
            }

            val move = getMatch(REG_MOVE, line)
            if (move.isNotEmpty()) {
                functions.add({
                    when (move) {
                        "right" -> {
                            pointer++
                        }
                        "left" -> {
                            pointer--
                        }
                    }
                })
                continue
            }

            val nextState = getMatch(REG_NEXT, line)
            if (nextState.isNotEmpty()) {
                actions[condition] = Action(nextState, functions)
            }
        }
        return State(actions)
    }

    private fun getMatch(regex: Regex, input: String): String {
        return regex.find(input)?.groupValues?.get(1) ?: ""
    }

    private fun start() {
        var nextState = firstState
        while (checkStep()) {
            val state = states[nextState]
            if (state != null) {
                val value = get(pointer)
                val action = state.actions[value]
                if (action != null) {
                    action.functions.forEach({ function -> function.invoke() })
                    nextState = action.nextState
                }
            }
        }
    }

    private fun checkStep(): Boolean {
        return ++step <= maxSteps
    }

    private fun set(index: Int, state: Int) {
        tape[index] = state
    }

    private fun get(index: Int): Int {
        return tape[index] ?: 0
    }

    private fun checksum(): Int {
        return tape.values.sum()
    }
}