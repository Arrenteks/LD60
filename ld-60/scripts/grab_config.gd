extends CharacterBody2D
class_name grabbable_item

var is_grabbed: bool = false
var is_inside_socket: bool = false
var mouse_offset: Vector2
var sockets: Array[Node]
var og_pos: Vector2
var tween: Tween
var snap_position: Vector2
var is_hovered: bool = false
@export var has_origin: bool = false
@export var weight: float = 5

func _ready():
	sockets = get_tree().get_nodes_in_group("item_socket")
	og_pos = self.position
	
func _physics_process(delta: float) -> void:
	if is_grabbed == true:
		is_inside_socket = false
		for socket in sockets:
			socket.release(self)
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position()-mouse_offset, weight * delta)
	elif has_origin == true && is_inside_socket != true:
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", og_pos, weight * delta)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and is_hovered:
			is_grabbed = true
			mouse_offset = get_global_mouse_position()-global_position
		else:
			is_grabbed = false
			for socket in sockets:
				if socket.has_overlapping_areas() and socket.get_overlapping_areas().has(self.get_node("MagnetPullZone")):
					if socket.is_socket_empty():
						socket.occupy(self)
						is_inside_socket = true
						snap_position = socket.position
						tween = get_tree().create_tween()
						tween.tween_property(self, "position", snap_position, weight* get_process_delta_time())
					


func _on_magnet_pull_zone_mouse_entered() -> void:
	is_hovered = true


func _on_magnet_pull_zone_mouse_exited() -> void:
	is_hovered = false
