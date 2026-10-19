extends Control
class_name EndOfDayMessage

@onready var evaluation: Label = $Panel/VBoxContainer/Evaluation
@onready var message: RichTextLabel = $Panel/VBoxContainer/Message

func set_text(success: bool):
	if success:
		evaluation.text = "Success"
		message.text = "Thank you for the amazing work today! Thanks to your answers our team was able to find the culprits to some of the crimes and gather much needed information on the other cases!\n\nGood job!"
	else:
		evaluation.text = "Failure"
		message.text = "The information you have gathered were unfortunately not helpful to the team. They are still searching for important clues and they did not make any notable progress.\nTry to deliver better work tomorrow."

func _on_next_day_button_pressed() -> void:
	Tickengine.day += 1
	get_tree().change_scene_to_file("res://scenes/GameArea.tscn")
