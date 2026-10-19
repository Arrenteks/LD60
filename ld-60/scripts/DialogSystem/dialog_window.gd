extends MarginContainer
class_name DialogueWindow

@onready var voice_acting: VoiceActing = $VoiceActing

@export var textbox: RichTextLabel
@export var typeSpeed: float = 15
@export var textDelay: float = 1
var isTyping: bool = false
var typeTimer: float = 0

# ---- Deprecated ---- #
var futureText: Array[String]
var arrayPosition: int = 0
# ---- Deprecated ---- #

var current_call: CallResource
var current_call_position: int = 0
@onready var speaker_name: Label = $VBoxContainer/SpeakerName

# Called when the node enters the scene tree for the first time.

#func _ready():
	##depending on where we will initilize the textbox for the character, wie need to setup the voice. The params will come from character ressources
	## we also need to assigne the caller to the Bus Caller, the reciever to the bus Reciever and incase of interuption the Interuptor
	#voice_acting.set_character_params(0.5,0.3,&"Caller")
	#addText(["first there was war", "Lorem ipsum dingsi bumsi", "Markov Grrrrrrrrrrrrrrrrrrrrrrrrrrrrr"])

func set_new_dialogue(new_call: CallResource):
	# TODO: close open windows i guess?
	current_call_position = 0
	current_call = new_call
	if current_call.diaologue.size() < current_call_position:
		print("Error when trying to add a new Dialogue. Dialogue -> DialogWindow -> set_new_dialogue()")
		return
	play_next_line()

func play_next_line():
	var current_dialogue: DialougPart = current_call.diaologue[current_call_position]
	var active_speaker: PersonResource = current_dialogue.speaker
	var active_text: String = current_dialogue.text
	voice_acting.set_character_params(active_speaker.base_pitch,active_speaker.pitch_varianz,&"Caller")
	speaker_name.text = active_speaker.name.person_name
	startText(active_text)

func addText(newText: Array[String]):
	futureText = newText
	startText(futureText[0])
	
func startText(newText: String):
	textbox.text = newText
	textbox.visible_characters = 0
	isTyping = true
	typeTimer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#typeTimer += delta
	#if(typeTimer >= 1.0/typeSpeed):
		#typeTimer = 0
		#if(isTyping):
			#if(textbox.visible_characters < textbox.get_total_character_count()):
				#textbox.visible_characters += 1
				#voice_acting.play_sound(textbox.text[textbox.visible_characters-1].to_lower())
			#else:
				#isTyping = false
				#arrayPosition += 1
				#if(arrayPosition < futureText.size()):
					#get_tree().create_timer(textDelay).timeout.connect(func(): startText(futureText[arrayPosition]))
	_advance_text(delta)

func _advance_text(delta: float) -> void:
	typeTimer += delta
	if(typeTimer >= 1.0/typeSpeed):
		typeTimer = 0
		if(isTyping):
			if(textbox.visible_characters < textbox.get_total_character_count()):
				textbox.visible_characters += 1
				voice_acting.play_sound(textbox.text[textbox.visible_characters-1].to_lower())
			else:
				isTyping = false
				current_call_position += 1
				if(current_call_position < current_call.diaologue.size()):
					get_tree().create_timer(textDelay).timeout.connect(func(): play_next_line())
				else:
					get_tree().create_timer(textDelay).timeout.connect(func(): startText(""))
