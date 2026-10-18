extends AudioStreamPlayer
class_name VoiceActing
var base_pitch: float = 0.3
var pitch_varianz : float = 0.1

const sounds = {
	'a':preload("res://audio/Alphabet/A.wav"),
	'b':preload("res://audio/Alphabet/B.wav"),
	'c':preload("res://audio/Alphabet/C.wav"),
	'd':preload("res://audio/Alphabet/D.wav"),
	'e':preload("res://audio/Alphabet/E.wav"),
	'f':preload("res://audio/Alphabet/F.wav"),
	'g':preload("res://audio/Alphabet/G.wav"),
	'h':preload("res://audio/Alphabet/H.wav"),
	'i':preload("res://audio/Alphabet/I.wav"),
	'j':preload("res://audio/Alphabet/J.wav"),
	'k':preload("res://audio/Alphabet/C.wav"),
	'l':preload("res://audio/Alphabet/L.wav"),
	'm':preload("res://audio/Alphabet/M.wav"),
	'n':preload("res://audio/Alphabet/N.wav"),
	'o':preload("res://audio/Alphabet/O.wav"),
	'p':preload("res://audio/Alphabet/P.wav"),
	'q':preload("res://audio/Alphabet/Q.wav"),
	'r':preload("res://audio/Alphabet/R.wav"),
	's':preload("res://audio/Alphabet/S.wav"),
	't':preload("res://audio/Alphabet/T.wav"),
	'u':preload("res://audio/Alphabet/U.wav"),
	'v':preload("res://audio/Alphabet/V.wav"),
	'w':preload("res://audio/Alphabet/W.wav"),
	'x':preload("res://audio/Alphabet/X.wav"),
	'y':preload("res://audio/Alphabet/X-2.wav"),
	'z':preload("res://audio/Alphabet/Z.wav"),
	' ':preload("res://audio/Alphabet/silence_short.wav"),
	'.':preload("res://audio/Alphabet/silence_long.wav")
}
func set_character_params(base_pitch : float, pitch_varianz : float, used_bus : String):
	bus = used_bus
	self.base_pitch = base_pitch
	self.pitch_varianz = pitch_varianz

func play_sound(sound):
	if !sounds.has(sound):
		sound = "."
	stream = sounds[sound]
	var effect = AudioServer.get_bus_effect(AudioServer.get_bus_index(bus),0)
	effect.pitch_scale = max(0.001,base_pitch + randf_range(- pitch_varianz/2, pitch_varianz/2))
	play()
