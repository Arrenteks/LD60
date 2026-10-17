extends Node

signal money_changed(value)
signal x_unlocked

var tutorial_completed: bool = false

var ingame: bool = false

#emit via SignalManager.money_changed.emit()
