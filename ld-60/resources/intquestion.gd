extends Question
class_name IntQuestion

@export var truthful_answer : int;

func give_answer(value) -> bool:
	if(!value.is_valid_int()):
		return false;
	
	return value as int == truthful_answer
