extends CharacterBody2D

var is_grabbed: bool = false
var mouse_offset
@export var weight = 5

func _physics_process(delta: float) -> void:
	if is_grabbed == true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position()-mouse_offset, weight * delta)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print('clicked on sprite')
			is_grabbed = true
			mouse_offset = get_global_mouse_position()-global_position
		else:
			is_grabbed = false
