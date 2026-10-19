extends Node2D
class_name CallInstance

const DIALOGUE = preload("uid://ccy2o7kramesx")

var status : CallManager.CallStatus
var call_ressource : CallResource
var plgCaller : PhoneLogicGroup # Light and Hole of caller
var plgReciever : PhoneLogicGroup # light and hole of reciever
var call_rev_group : CallRevGroup # teh cluster of cabels and the switch

var d : DialogueWindow
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#slotLightGroup.phone_logic_group_connected.connect(call_registered)
	pass # Replace with function body.

func connect_rev_group():
	pass

func set_caller_logic_group(phone_logic_group:PhoneLogicGroup):
	plgCaller = phone_logic_group
	plgCaller.cabel_disconnect.connect(remove_call_rev_group)

func set_reciever_logic_group(phone_logic_group:PhoneLogicGroup):
	plgReciever = phone_logic_group

func set_call_rev_group(call_rev_group : CallRevGroup):
	status =  CallManager.CallStatus.Connected
	
	if self.call_rev_group == call_rev_group:
		return
	
	print("callrev connected")
	self.call_rev_group = call_rev_group
	
	plgCaller.modluate_signal(Color(0.852, 0.431, 0.223, 1.0))
	if call_rev_group.schalter.get_talking():
		start_Caller_request()
	
	call_rev_group.schalter.talking_switch_flipped.connect(toogle_talking)
	call_rev_group.reciever_plugged_in.connect(try_start_Dialouge)
	

func remove_call_rev_group():
	if !call_rev_group:
		return
	call_rev_group.schalter.talking_switch_flipped.disconnect(toogle_talking)
	call_rev_group.reciever_plugged_in.disconnect(try_start_Dialouge)
	
	match status:
		CallManager.CallStatus.Connected:
			status = CallManager.CallStatus.Pending
			plgCaller.modluate_signal(Color(0.996, 1.0, 0.192, 1.0))
		CallManager.CallStatus.Running:
			status = CallManager.CallStatus.Ended
			plgCaller.modluate_signal(Color(0.19, 0.19, 0.19, 1.0))
	
	call_rev_group = null


func toogle_talking(talking:bool):
	if status == CallManager.CallStatus.Connected:
		start_Caller_request()
	if status == CallManager.CallStatus.Running:
		print("mute call")
	pass

func call_registered():
	if !plgCaller:
		return
	#print("registered")
	#print(plgCaller)
	#print(plgReciever)
	plgCaller.modluate_signal(Color(0.996, 1.0, 0.192, 1.0))

func start_Caller_request():
	status = CallManager.CallStatus.CallerRequestAcceptet
	print_debug("please talk to me")
	
	if d == null:
		d = DIALOGUE.instantiate()
		add_child(d)
	d.size = Vector2(1920,1080)
	d.position = Vector2(0,0)
	d.play_caller_request(call_ressource)
	
	plgCaller.modluate_signal(Color(0.254, 0.75, 0.774, 1.0))
	# TODO: START CALLER DIALOUGE

func start_call():
	status = CallManager.CallStatus.Pending
	
func interupt_call():
	status = CallManager.CallStatus.Interrupted
	plgCaller.modluate_signal(Color(0.388, 0.066, 0.007, 1.0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func try_start_Dialouge(socket: item_socket):
	print("help")
	print(status)
	if socket == plgReciever.socket && status == CallManager.CallStatus.CallerRequestAcceptet:
		plgCaller.modluate_signal(Color(0.0, 0.392, 0.05, 1.0))
		plgReciever.modluate_signal(Color(0.0, 0.392, 0.05, 1.0))
		status = CallManager.CallStatus.Running
		print_debug("hurray")
		d.play_dialoug()
		d.dialoug_over.connect(end_call)
		
		
		
		#var timer = Timer.new()
		#add_child(timer)
		#timer.wait_time = 10
		#timer.one_shot = true
		#timer.timeout.connect(end_call)
		#timer.start()
		
		
func end_call():
	match status:
		CallManager.CallStatus.Running:
			plgCaller.modluate_signal(Color(1.0, 1.0, 1.0, 1.0))
			plgReciever.modluate_signal(Color(1.0, 1.0, 1.0, 1.0))
			print("call ended")
		_:
			print("dont care")
	status = CallManager.CallStatus.Ended
	CallManager.call_list.erase(self)
	queue_free()
