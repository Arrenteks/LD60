extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PauseToggle"):
		toggle_pause()

func toggle_pause():
	visible = !visible
	var state = false
	if !get_tree().paused:
		state = true
	#visible = state
	get_tree().paused = state
	print("is paused?  ")
	print(get_tree().paused)


func _on_continue_button_down() -> void:
	toggle_pause()


func _on_continue_mouse_entered() -> void:
	pass # Replace with function body.
	
