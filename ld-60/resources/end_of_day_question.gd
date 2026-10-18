@abstract
extends Resource
class_name Question

@export var questionType: QuestionType;
@export var questionText : String;

@abstract func give_answer(value) -> bool


enum QuestionType{Bool, Number, Picker}
