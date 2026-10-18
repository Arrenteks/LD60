extends Button

#function to quit the game
func _on_button_down() -> void:
	print("quit")
	get_tree().quit()
	
#function to play sounds or something on hoverbutton
func _on_mouse_entered() -> void:
	return
