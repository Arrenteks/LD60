extends Button

#variable for the scene to be loaded
@export var _load_scene : PackedScene

#function to load scene on button press
func _on_button_down() -> void:
	if(_load_scene):
		get_tree().change_scene_to_packed(_load_scene)

#function to play sounds or something on hoverbutton
func _on_mouse_entered() -> void:
	return
