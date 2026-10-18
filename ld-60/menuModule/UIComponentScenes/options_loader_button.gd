extends Button

#either option scene or node
@export var option_menu : PackedScene

#function to open the options
func _on_button_down() -> void:
	if(option_menu.can_instantiate()):
		var newMenu = option_menu.instantiate()
		get_tree().root.add_child(newMenu)
		newMenu.closed.connect(_return_to_main)
		get_parent().hide()

func _return_to_main():
	get_parent().show()

#function to play sounds or something on hoverbutton
func _on_mouse_entered() -> void:
	return
