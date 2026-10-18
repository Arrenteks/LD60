extends Resource
class_name TelephoneNumberData

@export var area_code : String
@export var number : String
var telephone_number

func _get_text() -> String:
	return area_code+number
