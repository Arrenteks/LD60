extends Line2D

@export var connection_start: Node2D
@export var connection_end: Node2D

func _process(_delta: float) -> void:
	if is_instance_valid(connection_start) and is_instance_valid(connection_end):
		set_point_position(0, to_local(connection_start.global_position))
		set_point_position(1, to_local(connection_end.global_position))
