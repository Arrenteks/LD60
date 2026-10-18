extends PersonData
class_name TelephoneNumberData

@export var area_code : String
@export var number : String
var person_telephone_number

func _get_text() -> String:
	#only area code because we ignore the drehscehiben thingy
	return area_code
