extends Node2D
class_name PhoneLogicGroup

@export var phone_number : String
@export var active_tint_color : Color
@export var inactive_tint_color : Color

@onready var licht: Sprite2D = $Licht
@onready var socket: item_socket = $ItemSocket01

signal phone_logic_group_connected(group : PhoneLogicGroup)
signal cabel_disconnect


func _ready() -> void:
	if !CallManager.phone_logic_groups.has(self):
		CallManager.phone_logic_groups.append(self)
	
	CallManager.connect_logic_group.connect(try_begin_call)
	socket.socket_occupied.connect(cable_connected)
	socket.socket_emptied.connect(cabel_disconnected)
 
	pass
	#SignalManager.start_call.connect(try_begin_call)


func try_begin_call(call: CallInstance):
	var phone_number = call.call_ressource
	print (call.call_ressource.caller.telephone_number._get_text())
	if(self.phone_number == phone_number.caller.telephone_number._get_text()):
		print("try call")
		phone_logic_group_connected.emit(self)
		#call.set_logic_group(self)


func cable_connected(cabel : grabbable_item):
	cabel.slotted_in(socket)
	pass

func cabel_disconnected():
	cabel_disconnect.emit()
	pass
func signal_call_pending():
	licht.modulate = active_tint_color

func modluate_signal(color:Color):
	licht.modulate = color
func end_call():
	licht.modulate = inactive_tint_color
