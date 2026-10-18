extends Node

var currentlyDialed: Array[int]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.numberSelected.connect(_numberPicked)

func _numberPicked(value: int):
	if(value in range(0,9)):
		currentlyDialed.append(value)
	elif(value == -1):
		currentlyDialed.pop_back()
	elif(value == 10):
		return #dial the number and clear

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
