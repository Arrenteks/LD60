extends Node2D

var threads: Array[Dictionary] = []

@export var line_width: float = 3.0
@export var line_color: Color = Color("#c80000") # Krimi-Rot

func _on_ready() -> void:
	SignalManager.item_picked_up.connect(_on_needle_picked_up)

func _process(_delta: float) -> void:
	if threads.size() > 0:
		queue_redraw()

func _draw() -> void:
	for thread in threads:
		var needle = thread["needle"]
		
		if is_instance_valid(needle):
			var start = to_local(thread["start_pos"])
			var end = to_local(needle.global_position)
			
			draw_line(start, end, line_color, line_width, true)

func _on_needle_picked_up(start_position: Vector2, needle_node: grabbable_item) -> void:
	print("yes")
	for thread in threads:
		if thread["needle"] == needle_node:
			return 
			
	var new_thread = {
		"start_pos": start_position,
		"needle": needle_node.position
	}
	threads.append(new_thread)
