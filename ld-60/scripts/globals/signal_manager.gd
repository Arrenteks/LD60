extends Node

signal money_changed(value)
signal x_unlocked

var tutorial_completed: bool = false

var ingame: bool = false

signal socketOccupancy_changed(is_occupied: bool)

#emit via SignalManager.money_changed.emit()
