@abstract
class_name QuestionRow extends Control

@export var attched_question : Question

func attach_question(question: Question):
	attched_question = question;
 
@abstract func was_answered_truthfully() -> bool;
@abstract func setup()
