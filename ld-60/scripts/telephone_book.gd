extends Control

const TELEPHONE_BOOK_ROW = preload("uid://dxktmclx6en1x")
@onready var page: VBoxContainer = $Page

func _ready() -> void:
	
	for i in range(10):
		var new_row: TelephoneBookRow = TELEPHONE_BOOK_ROW.instantiate()
		page.add_child(new_row)
		new_row.random_bs_go()
	
