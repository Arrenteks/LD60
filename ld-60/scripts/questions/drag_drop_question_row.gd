extends QuestionRow
class_name QuestionRowData


@onready var dropable: HBoxContainer = $Dropable
@onready var questiontext: Label = $Questiontext

const DRAG_AND_DROP_QUESTION_ROW_DATAS = preload("uid://bnxwinwepecpg")


var person_datas : Array[PersonData]


func setup():
	questiontext.text = attched_question.questionText

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is AddressData || data is NameData || data is TelephoneNumberData
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	person_datas.append(data)
	var datarow : QuestionRowDatas = DRAG_AND_DROP_QUESTION_ROW_DATAS.instantiate()
	datarow.removal_triggered.connect(on_row_removed)
	dropable.add_child(datarow)
	
	datarow.set_data(data, person_datas.find(data))
	
func on_row_removed(index: int) -> void:
		person_datas.remove_at(index)
		

func was_answered_truthfully() -> bool:
	return attched_question.give_answer(person_datas)
