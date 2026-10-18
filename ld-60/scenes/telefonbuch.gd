extends Sprite2D

const TELEPHONE_BOOK = preload("uid://c2go5f5ld4qoi")
@onready var marker: Marker2D = $Marker2D

var _telephonebook_open = false;
var _phonebook_instance;



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		toggle_phonebook()
		



func toggle_phonebook():
	_telephonebook_open = !_telephonebook_open
	
	if(_telephonebook_open):
		_phonebook_instance = TELEPHONE_BOOK.instantiate()
		marker.add_child(_phonebook_instance)
	else:
		_phonebook_instance.queue_free()
