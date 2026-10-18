extends Button

#either option scene or node
@export var option_menu : PackedScene

#function to open the options
func _on_button_down() -> void:
	if(option_menu.can_instantiate()):
		var newMenu = option_menu.instantiate()
		owner.get_parent().add_child(newMenu)
		newMenu.closed.connect(_return_to_main)
		owner.hide()

func _return_to_main():
	owner.visible = !owner.visible

#function to play sounds or something on hoverbutton
func _on_mouse_entered() -> void:
	return
