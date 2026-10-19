extends Control

const TELEPHONE_BOOK_ROW = preload("uid://dxktmclx6en1x")
@onready var page: VBoxContainer = $Page

const TEMP_PERSON: PersonResource = preload("uid://bf08012vro2ae")
@export var people : Array[PersonResource]

func _ready() -> void: 
	people.sort_custom(func (a:PersonResource,b:PersonResource): return a.name._get_text() < b.name._get_text())
	for i in people:
		var new_row: TelephoneBookRow = TELEPHONE_BOOK_ROW.instantiate()
		page.add_child(new_row)
		new_row.person = i
		new_row.set_person_data()
	
