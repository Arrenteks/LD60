extends HBoxContainer
class_name TelephoneBookRow

var characters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

var person: PersonData

@onready var person_name: Button = $Name
@onready var address: Button = $Address
@onready var telephone_number: Button = $TelephoneNumber

func set_data(_name: String, _address: String, _telephone_number: String) -> void:
	person_name.text = _name
	address.text = _address
	telephone_number.text = _telephone_number

func random_bs_go() -> void:
	var new_name = generate_word(characters, 10)
	var new_address = str(randi())
	var new_phone_number = str(randi())
	set_data(new_name, new_address, new_phone_number)

func generate_word(chars, length):
	var word: String
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word
