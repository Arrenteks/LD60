extends Area2D
class_name item_socket

@export var is_occupied: bool = false
@export var stored_item: Node = null

func is_socket_empty() -> bool:
	return stored_item == null
	
func occupy(item: Node) -> void:
	if not is_socket_empty():
		return
	stored_item = item
	#SignalManager.socketOccupancy_changed.emit(true)
	
func release(item: Node) -> void:
	if stored_item != item:
		return
	stored_item = null
	#SignalManager.socketOccupancy_changed.emit(false)
