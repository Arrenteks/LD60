extends Area2D
class_name TalkingSwitch

@onready var sprite: Sprite2D = $Schalter01

var _talking : bool = false
signal talking_switch_flipped(talking:bool)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func flip_switch():
	_talking = !_talking
	sprite.flip_h = !sprite.flip_h
	talking_switch_flipped.emit(_talking)

func get_talking() -> bool :
	return _talking

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		flip_switch()
		print("clicked")
