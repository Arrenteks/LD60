extends Node2D
class_name CallRevGroup


@onready var receiver: grabbable_item = $Receiver01
@onready var caller: grabbable_item = $Caller01
@onready var schalter: TalkingSwitch = $Schalter

var receiver_connected : bool = false
var caller_connected : bool = false

#listent to by the call instance. its here because only localy relevant. If a call needs to be connectet, the gruop is alread known
signal reciever_plugged_in

func _ready() -> void:
	caller.i_was_sloted_in.connect(caller_Cabel_connected)
	receiver.i_was_sloted_in.connect(reciever_cable_connected)
func connect_socket(node : Node):
	pass
		
		
func caller_Cabel_connected(socket:item_socket):
	CallManager.try_connect_call_rev_groupe.emit(socket,self)
	print("caller connected")

func caller_Cabel_disconnected():
	pass
func reciever_cable_connected(socket:item_socket):
	reciever_plugged_in.emit(socket)
	#print("reciever connected")
