extends QuestionRow
@onready var text_edit: TextEdit = $TextEdit

func was_answered_truthfully() -> bool:
	return attched_question.give_answer(text_edit.text)
