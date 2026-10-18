extends QuestionRow


@onready var text_edit: TextEdit = $TextEdit

@onready var question_text: Label = $QuestionText

func setup() -> void:
	question_text.text = attched_question.questionText

func was_answered_truthfully() -> bool:
	return attched_question.give_answer(text_edit.text)
