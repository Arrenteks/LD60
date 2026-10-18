extends QuestionRow
@onready var check_box: CheckBox = $CheckBox

func was_answered_truthfully() -> bool:
	return attched_question.give_answer(check_box.button_pressed)
