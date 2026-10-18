extends Question
class_name DragDropQuestion

@export var correct_datas : Array[PersonData]



func give_answer(value) -> bool:
	var datas := value as Array[PersonData]
	
	if datas.size() != correct_datas.size():
		return false;
	
	for data in datas:
		if(!correct_datas.has(data)):
			return false
			break
	
	return true;
