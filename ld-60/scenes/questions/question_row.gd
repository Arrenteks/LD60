@abstract
class_name QuestionRow extends HBoxContainer

@export var attched_question : Question

@onready var question_text: Label = $QuestionText

func set_text(new_text : String):
	question_text.text = new_text
	
@abstract func was_answered_truthfully() -> bool;
