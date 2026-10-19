extends Area2D
class_name item_socket

@export var is_occupied: bool = false
@export var stored_item: grabbable_item = null

signal socket_occupied(cabel : grabbable_item)
signal socket_emptied

func is_socket_empty() -> bool:
	return stored_item == null
	
func occupy(item: grabbable_item) -> void:
	if not is_socket_empty():
		return
	stored_item = item
	stored_item.slotted_in(self)
	#SignalManager.socketOccupancy_changed.emit(item ,true)
	
func release(item: grabbable_item) -> void:
	if stored_item != item:
		return
	stored_item.slotted_out()
	stored_item = null
	socket_emptied.emit()
	#SignalManager.socketOccupancy_changed.emit(item, false)
