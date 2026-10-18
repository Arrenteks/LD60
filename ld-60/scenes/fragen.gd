extends Sprite2D


const QUESTION_SHEET = preload("uid://dd06wyaj3erju")

var question_open : bool = false;
var question_instance;
@onready var marker: Marker2D = $Marker2D





func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event is InputEventMouseButton && event.is_pressed()):
		toggle_questions();
		
		
		
func toggle_questions():
	question_open = !question_open
	
	if(question_open):
		question_instance = QUESTION_SHEET.instantiate()
		marker.add_child(question_instance)
	else:
		question_instance.queue_free()
