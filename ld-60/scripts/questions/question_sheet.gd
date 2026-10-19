extends Control

@export var day_resource : Day = preload("uid://ba2jk6fodusdk")
@export var question_number_per_page = 4;
@export var current_page = 1;

const BOOL_QESTION_ROW = preload("uid://chj175d3wp6un")
const INT_QUESTION_ROW = preload("uid://dh1du1dvk13fk")
const DRAG_DROP_QUESTION_ROW = preload("uid://cp1e82c30hcvl")


@onready var question_rows: VBoxContainer = $ColorRect/QuestionRows

var rows : Array[QuestionRow]


func _ready() -> void:
	SignalManager.end_day.connect(finish_day)
	
	for question in day_resource.questions:
		_instantiate_question_row(question)
		
	_show_current_page(current_page)
		

func _instantiate_question_row(question : Question):
	var row : QuestionRow
	match question.questionType:
		Question.QuestionType.Bool:
			row = BOOL_QESTION_ROW.instantiate()
		Question.QuestionType.Number:
			row = INT_QUESTION_ROW.instantiate()
		Question.QuestionType.Picker:
			row = DRAG_DROP_QUESTION_ROW.instantiate()
		_:
			print("unsupported question Type")
	
	question_rows.add_child(row)
	row.visible = false
	row.attach_question(question)
	row.setup()
	rows.append(row)

func _show_current_page(curr : int):
	for n in range(question_number_per_page):
		if(((curr - 1) * question_number_per_page + n) >= rows.size()):
			break
		
		rows[(curr - 1) * question_number_per_page + n].visible = true;
		
		
func _hide_current_page(curr:int):
	for n in range(question_number_per_page):
		if(((curr - 1) * question_number_per_page + n) >= rows.size()):
			break
		
		rows[(curr - 1) * question_number_per_page + n].visible = false;




func count_correct_answers() -> int:
	var correct_answers = 0
	for row in rows:
		if(row.was_answered_truthfully()):
			correct_answers += 1
	
	print(str(correct_answers) + " questions were answered correctly")
	return correct_answers


func _on_button_pressed() -> void:
	count_correct_answers()
	
	
func finish_day():
	var correct_answers := count_correct_answers();
	var correct_percentile := (correct_answers / day_resource.questions.size()) * 100
	SignalManager.correct_percent = correct_percentile


func _on_next_page_pressed() -> void:
	_hide_current_page(current_page)
	var page_count : int = ceil(float(day_resource.questions.size()) / float(question_number_per_page))
	print(page_count)
	current_page += 1
	current_page = (current_page % page_count + page_count) % page_count
	print(current_page)
	_show_current_page(current_page)


func _on_prev_page_pressed() -> void:
	_hide_current_page(current_page)
	var page_count : int = ceil(float(day_resource.questions.size()) / float(question_number_per_page))
	print(page_count)
	current_page -= 1
	current_page = (current_page % page_count + page_count) % page_count
	print(current_page)
	_show_current_page(current_page)
