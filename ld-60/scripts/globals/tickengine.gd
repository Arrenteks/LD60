class_name TickEngine extends Node

@export var tick_timer_duration : float = 1.0;
@export var start_hour_tens : int = 0;
@export var start_hour_first : int = 8;
@export var start_minute_tens : int = 0;
@export var start_minute_first : int = 0;
@export var is_paused : bool = false;

signal on_tick;

@onready var tick_timer: Timer = $Timer

var game_time : Game_Time;
var game_time_event_dictionary : Dictionary[String, Game_Routine_Event]

const TEST_CALL = preload("uid://i1bayk800x8w")


func toggle_pause():
	is_paused = !is_paused;
	tick_timer.paused = is_paused; 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_time = Game_Time.new(start_hour_tens, start_hour_first, start_minute_tens, start_minute_first)
	game_time_event_dictionary["08:05"] = Game_Routine_Event.new(GameRoutineEventType.Call, TEST_CALL)
	tick_timer.start(tick_timer_duration);

func _on_timer_timeout() -> void:
	print(game_time.get_current_time_string())
	_try_invoke_game_time_event(game_time);
	on_tick.emit(game_time.get_current_time());
	game_time.advance_minutes()
	
	tick_timer.start(tick_timer_duration);
	

#checks if a given game time event exists
func _check_game_time_event_exists(game_time : String) -> bool:
	return game_time_event_dictionary.has(game_time);
	
	
#checks which game time event should be invoked and invokes the given Signal on the SignalBus
func _try_invoke_game_time_event(game_time : Game_Time) -> void:
	if(_check_game_time_event_exists(game_time.get_current_time_string())):
		var game_time_event : Game_Routine_Event = game_time_event_dictionary[game_time.get_current_time_string()];
		match game_time_event.routine_event_type:
			GameRoutineEventType.Call:
				SignalManager.start_call.emit(game_time_event.caller_id)
				print("Someone is calling! His Id is: " + str(game_time_event.caller_id))
			GameRoutineEventType.StartDay:
				SignalManager.start_day.emit()
				print("Welcome at work!")
			GameRoutineEventType.EndDay:
				SignalManager.end_day.emit()
				print("See you tomorrow!")
			GameRoutineEventType.Boss:
				SignalManager.boss.emit()
				print("Your boss wants a word with you! Get ready for the pink slip, just in case.")
			_:
				print("Type does not match any supported type.")


#different types of events
enum GameRoutineEventType{StartDay, EndDay, Call, Boss}

#Class for Events during Game Time
class Game_Routine_Event:
	var routine_event_type : GameRoutineEventType
	
	#only set to value if routine_event_type equals Call
	var caller_id = null
	
	func _init(new_routine_event_type : GameRoutineEventType, caller = null) -> void:
		routine_event_type = new_routine_event_type
		
		if(new_routine_event_type == GameRoutineEventType.Call):
			caller_id = caller


#Class to describe the Game Time
class Game_Time:
		var min_first : int
		var min_tens : int
		var hour_first : int
		var hour_tens : int
		
		#basic constructor
		func _init(start_hour_tens :int,  start_hour_first :int, start_minutes_tens : int, start_minutes_first : int) -> void:
			self.hour_tens = start_hour_tens;
			self.hour_first = start_hour_first;
			self.min_tens = start_minutes_tens;
			self.min_first = start_minutes_first;
			
		
		#advances time by 1 minute, resets to 0 and automatically advances the hours if 60 is reached
		func advance_minutes(minutes_to_advance : int = 1):
			min_first += minutes_to_advance
			
			if(min_first >= 10):
				min_tens += 1
				min_first = 0
				
			if(min_tens >= 6):
				min_tens = 0
				advance_hours()
					
		
		#advances time by 1 hour, resets to 0 if 24 is reached
		func advance_hours(hours_to_advance : int = 1):
			hour_first += hours_to_advance
			
			
			if(hour_first >= 10):
				hour_first = 0
				hour_tens += 1
				
			if(hour_tens >= 2):
				hour_tens = 0
				hour_first = 0
				
				
		
		#creates a copy of the current time and returns that
		func get_current_time() -> Game_Time:
			return Game_Time.new(hour_tens, hour_first, min_tens, min_first)
		
		#measures equality by checking against the hours and minutes of the other game time object
		func equals(other_game_time: Game_Time) -> bool: 
			return self.hour_tens == other_game_time.hour_first

		
		func get_current_time_string() -> String:
			return "%s%s:%s%s" %[hour_tens, hour_first, min_tens, min_first]
