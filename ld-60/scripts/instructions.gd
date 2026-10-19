extends Control
class_name Instructions

@onready var day_count: Label = $Panel/VBoxContainer/DayCount
@onready var info_message: RichTextLabel = $Panel/VBoxContainer/InfoMessage
var day_infos


func _ready() -> void:
	Tickengine.start_day()

func _on_close_pressed() -> void:
	Tickengine.toggle_pause()
	self.queue_free()

func set_text(day_number: String, information: String) -> void:
	day_count.text = day_number
	info_message.text = information
