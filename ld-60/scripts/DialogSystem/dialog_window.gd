extends MarginContainer
@onready var voice_acting: VoiceActing = $VoiceActing

@export var textbox: RichTextLabel
@export var typeSpeed: float = 15
@export var textDelay: float = 1
var isTyping: bool = false
var typeTimer: float = 0
var futureText: Array[String]
var arrayPosition: int = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	#depending on where we will initilize the textbox for the character, wie need to setup the voice. The params will come from character ressources
	# we also need to assigne the caller to the Bus Caller, the reciever to the bus Reciever and incase of interuption the Interuptor
	voice_acting.set_character_params(0.5,0.3,&"Caller")
	addText(["first there was war", "Lorem ipsum dingsi bumsi", "Markov Grrrrrrrrrrrrrrrrrrrrrrrrrrrrr"])
	
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
	typeTimer += delta
	if(typeTimer >= 1.0/typeSpeed):
		typeTimer = 0
		if(isTyping):
			if(textbox.visible_characters < textbox.get_total_character_count()):
				textbox.visible_characters += 1
				voice_acting.play_sound(textbox.text[textbox.visible_characters-1].to_lower())
			else:
				isTyping = false
				arrayPosition += 1
				if(arrayPosition < futureText.size()):
					get_tree().create_timer(textDelay).timeout.connect(func(): startText(futureText[arrayPosition]))
			
