extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	if(visible):
		visible = !visible
	if(get_tree().paused):
		get_tree().paused = !get_tree().paused
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	pass # Replace with function body.


func _on_continue_button_down() -> void:
	pass # Replace with function body.


func _on_continue_mouse_entered() -> void:
	pass # Replace with function body.
