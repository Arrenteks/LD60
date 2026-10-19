extends HBoxContainer
class_name TelephoneBookRow

#var characters = [
	#"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
	#]

var person: PersonResource

@onready var person_name_button: TelephoneBookDragable = $Name
@onready var address_button: TelephoneBookDragable = $Address
@onready var telephone_number_button: TelephoneBookDragable = $TelephoneNumber
@onready var town_button: TelephoneBookDragable = $Town

func set_text(_name: String, _address: String, _telephone_number: String, _town : String) -> void:
	person_name_button.text = _name
	address_button.text = _address
	telephone_number_button.text = _telephone_number
	town_button.text = _town

func set_person_data() -> void:
	set_text(person.name._get_text(), person.address._get_text(), person.telephone_number._get_text(), person.town._get_text())
	person_name_button.person_data = person.name
	address_button.person_data = person.address
	telephone_number_button.person_data = person.telephone_number
	town_button.person_data = person.town
	

#func random_bs_go() -> void:
	#var new_name = generate_word(characters, 10)
	#var new_address = str(randi())
	#var new_phone_number = str(randi())
	#set_text(new_name, new_address, new_phone_number)
#
#func generate_word(chars, length):
	#var word: String
	#var n_char = len(chars)
	#for i in range(length):
		#word += chars[randi()% n_char]
	#return word
