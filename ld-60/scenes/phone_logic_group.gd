extends Node2D

@export var phone_number : String
@export var active_tint_color : Color
@export var inactive_tint_color : Color

@onready var licht: Sprite2D = $Licht

func _ready() -> void:
	SignalManager.start_call.connect(try_begin_call)


func try_begin_call(phone_number: String):
	if(self.phone_number == phone_number):
		begin_call()

func begin_call():
	licht.modulate = active_tint_color

func end_call():
	licht.modulate = inactive_tint_color
