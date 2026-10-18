extends QuestionRow
@onready var check_box: CheckBox = $CheckBox

@onready var question_text: Label = $QuestionText


func setup() -> void:
	question_text.text = attched_question.questionText

func was_answered_truthfully() -> bool:
	return attched_question.give_answer(check_box.button_pressed)
