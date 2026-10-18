extends Control
class_name QuestionRowDatas

signal removal_triggered

@onready var data_text: Label = $HBoxContainer/DataText
var index : int

func set_data(data : PersonData, index : int) -> void:
	self.index = index
	data_text.text = data._get_text()

func _on_button_pressed() -> void:
	removal_triggered.emit()
	self.queue_free()
	
