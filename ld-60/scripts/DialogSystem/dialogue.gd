extends Control

@onready var dialog_window: DialogueWindow = $DialogWindow
const TEST_CALL = preload("uid://i1bayk800x8w")

func _ready() -> void:
	start_call(TEST_CALL)

func start_call(call: CallResource):
	dialog_window.set_new_dialogue(call)
