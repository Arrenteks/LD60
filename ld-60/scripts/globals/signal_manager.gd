extends Node

signal money_changed(value)
signal x_unlocked
signal numberSelected(value)

signal start_day
signal end_day
signal start_call(caller_id)
signal boss

var tutorial_completed: bool = false

var ingame: bool = false

signal socketOccupancy_changed(is_occupied: bool)

#emit via SignalManager.money_changed.emit()
