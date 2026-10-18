extends Control

@export var day_resource : Day = preload("uid://ba2jk6fodusdk")

const BOOL_QESTION_ROW = preload("uid://chj175d3wp6un")
const INT_QUESTION_ROW = preload("uid://dh1du1dvk13fk")


@onready var question_rows: VBoxContainer = $ColorRect/QuestionRows




func _ready() -> void:
	for question in day_resource.questions:
		_instantiate_question_row(question)
		

func _instantiate_question_row(question : Question):
	match question.questionType:
		Question.QuestionType.Bool:
			var row = BOOL_QESTION_ROW.instantiate()
			question_rows.add_child(row)
		Question.QuestionType.Number:
			var row = INT_QUESTION_ROW.instantiate()
			question_rows.add_child(row)
		_:
			print("unsupported question Type")
			
			
