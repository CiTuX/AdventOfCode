package ch.citux.aoc

import org.jetbrains.spek.api.dsl.ActionBody
import org.jetbrains.spek.engine.Scope
import org.jetbrains.spek.engine.SpekTestEngine

val ActionBody.input: String
    get() {
        val self = this as SpekTestEngine.ActionCollector
        val action = self.root.children.elementAt(0).parent.get() as Scope.Action
        return action.displayName.removePrefix("on ")
    }