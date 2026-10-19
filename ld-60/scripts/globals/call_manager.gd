extends Node

enum CallStatus{Pending, Connected, CallerRequestAcceptet, Running, Interrupted, Ended}
const CALL_INSTANCE = preload("uid://brdo8ibfvevex")

signal interrupt_call
signal call_started


var phone_logic_groups : Array[PhoneLogicGroup]

#var call_dictionary : Dictionary[CallResource, CallStatus]
var call_list : Array[CallInstance]

signal connect_logic_group(callinstance:CallInstance)
signal try_connect_call_rev_groupe(socket:item_socket, rev_group : CallRevGroup)


func _ready() -> void:
	SignalManager.start_call.connect(start_call)
	try_connect_call_rev_groupe.connect(try_connect_ref_g)

func start_call(call_resource : CallResource):
	for i in phone_logic_groups:
		if phone_logic_groups.count(i) > 1:
			print_debug(str(i.phone_number)+" has more than one slot. this will break stuff!")
	for call in call_list:
		if(call.status == CallStatus.Running):
			interrupt_call.emit(call)
			call.interupt_call()
			break
	
	var instance : CallInstance= CALL_INSTANCE.instantiate()
	call_list.append(instance)
	instance.call_ressource = call_resource
	for plg in phone_logic_groups:
		if plg.phone_number == call_resource.caller.telephone_number._get_text():
			instance.set_caller_logic_group(plg)
	for plg in phone_logic_groups:
		if plg.phone_number == call_resource.ceciever.telephone_number._get_text():
			instance.set_reciever_logic_group(plg)
	
	if instance.plgCaller == null || instance.plgReciever == null:
		print_debug("somethigs wrong")
	
	print(instance.call_ressource.callId)
	get_tree().root.add_child(instance)
	
	connect_logic_group.emit(instance)
	instance.call_registered()
	
	#
	#call_dictionary[call_resource] = CallStatus.Pending
	#call_resource.emit(call_resource)
	
func try_connect_ref_g(socket:item_socket, rev_group : CallRevGroup):
	#print("try connect ref")
	var callwithsocket : CallInstance
	for call in call_list:
		if socket == call.plgCaller.socket:
			callwithsocket = call
	if callwithsocket != null:
		callwithsocket.set_call_rev_group(rev_group)
		pass
	
