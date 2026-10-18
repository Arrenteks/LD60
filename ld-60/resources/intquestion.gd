extends Question
class_name IntQuestion

@export var truthful_answer : int;

func give_answer(value) -> bool:
	return value is int && value == truthful_answer
