extends Node2D

@export var hour_hand: Node2D
@export var minute_hand: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set to tick engine start time 
	minute_hand.rotation = deg_to_rad(6) * (Tickengine.start_minute_tens*10+Tickengine.start_minute_first)
	hour_hand.rotation = deg_to_rad(30) * (Tickengine.start_hour_tens*10+Tickengine.start_hour_first) + deg_to_rad(0.5) * ((Tickengine.start_minute_tens*10+Tickengine.start_minute_first))
	Tickengine.on_tick.connect(clock_goes_round)
	pass # Replace with function body.

func clock_goes_round(game_time:Tickengine.Game_Time)-> void:
	minute_hand.rotation = deg_to_rad(6) * (game_time.min_tens*10+game_time.min_first)
	hour_hand.rotation = deg_to_rad(30) * (game_time.hour_tens*10+game_time.hour_first) + deg_to_rad(0.5) * ((game_time.min_tens*10+game_time.min_first))
	#hour_hand.rotation = deg_to_rad(30) * (game_time.hour_tens*10+game_time.hour_first)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
