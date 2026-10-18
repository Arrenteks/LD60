@abstract
extends Resource
class_name PersonData

@export var name: NameData
@export var address: AddressData
@export var telephone_number: TelephoneNumberData
@export var base_pitch : float  = 0.5
@export var pitch_varianz : float = 0.1
@abstract func _get_text() -> String
