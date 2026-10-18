extends MarginContainer

@export var _selectorButtons :ButtonGroup
@export var _GeneralSettings : Node
@export var _GameplaySettings : Node
@export var _GraphicsSettings : Node
@export var _AudioSettings : Node
@export var _KeybindingsSettings : Node

signal closed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_selectorButtons.pressed.connect(_on_selection_changed)
	pass # Replace with function body.

func _on_selection_changed(target: BaseButton):
	return;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PauseToggle"):
		closed.emit()
		queue_free()
	

func _on_general_button_toggled(toggled_on: bool) -> void:
	if(_GeneralSettings):
		_GeneralSettings.visible = toggled_on



func _on_gameplay_button_toggled(toggled_on: bool) -> void:
	if(_GameplaySettings):
		_GameplaySettings.visible = toggled_on


func _on_graphic_button_toggled(toggled_on: bool) -> void:
	if(_GraphicsSettings):
		_GraphicsSettings.visible = toggled_on


func _on_audio_button_toggled(toggled_on: bool) -> void:
	if(_AudioSettings):
		_AudioSettings.visible = toggled_on


func _on_keybind_button_toggled(toggled_on: bool) -> void:
	if(_KeybindingsSettings):
		_KeybindingsSettings.visible = toggled_on


func _on_close_button_down() -> void:
	closed.emit()
	queue_free()
