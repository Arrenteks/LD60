extends Node2D

@onready var instructions: Instructions = $UI/Instructions
@onready var end_of_day_message: EndOfDayMessage = $UI/EndOfDayMessage

var instruction_data = [
	"Good Morning. \nFor the next few days your job will be here in the telephone exchange centre. Our investigation team has compiled questions based on already gathered intel to current cases. You will need to answer them by listening in to the calls that go through your station every day and consulting telephone-book. Make sure you have all the answers ready at the end of the day at 4pm.\n\nHere are the current cases you will be given questions to, and if you have never worked on such a station before, I have attached a note below where your work-process is explained in detail:\n\n- A groecry theft at the local supermarket in Feyshield\n- A bankrobbery\n- A missing person in Holloward\nHave a good day!\n\n[b]How the telephone exchange station works:[/b]\n\nblinking lamp indicates incoming call\n\nconnect a incoming cable to the slot of the incoming call\n\nenable the corresponding switch to talk to the new caller\n\nlisten to the desired connection the caller wants you to establish\n\nslot the corresponding outgoing cable into the frequency the caller wants to connect to\n\nconsult the telephone book in case callers don't know the number they want to reach\nleave the switch enabled to listen to the call\n\na newly connected call will overwrite the last call that is being listend to, avoid having multiple calls overlaping each other\n\nLook at the questions sheet at the start of the day before the first call comes in and answer the questions throughout the day\n\nTo make things easier, you can directly drag information from the telephone book into most answer fields",
	"Good Morning, here is your list of active cases for this day! The team has compiled the questiosn already and the paper is waiting at your station: \n\n- Vandalism at the Townhall in Winterholde\n- Bankrobbery\n- Bankrobbery in Bellport\n- Missing Person in Holloward\n\nHave a good day!",
	"Good Morning, here is your list of active cases for this day! The team has compiled the questiosn already and the paper is waiting at your station: \n\n- Multiple break-ins in Winterholde\n- Bankrobbery in Bellport\n- Stolen car in Feyshield\n- Missing Person in Holloward\n\nHave a good day!"
]

func _ready() -> void:
	SignalManager.end_day.connect(day_ended)
	set_instructions()

func set_instructions():
	var current_day = Tickengine.day
	instructions.set_text("Day" + str(current_day),instruction_data[current_day-1])

func day_ended():
	get_tree().create_timer(0.2).timeout.connect(open_end_message)

func open_end_message():
	end_of_day_message.set_text(true if SignalManager.correct_percent >= 0.5 else false)
	end_of_day_message.visible = true
