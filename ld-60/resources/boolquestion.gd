class_name BoolQuestion extends Question

@export var truthful_statement : bool;


func give_answer(value) -> bool:
	return value is bool && value == truthful_statement;
