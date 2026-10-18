extends Node

var newConfig = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func saveGeneralSettings(key: String, value):
	newConfig.set_value("General", key, value)

func loadGeneralSettings():
	var generalSettings = {}
	for key in newConfig.get_section_keys("General"):
		generalSettings[key] = newConfig.get_value("General", key)
	return generalSettings

func saveGraphicSettings(key: String, value):
	newConfig.set_value("Graphics", key, value)

func loadGraphicSettings():
	var graphicSettings = {}
	for key in newConfig.get_section_keys("Graphics"):
		graphicSettings[key] = newConfig.get_value("Graphics", key)
	return graphicSettings

func saveSoundSettings(key: String, value):
	newConfig.set_value("Sound", key, value)


func loadSoundSettings():
	var soundSettings = {}
	for key in newConfig.get_section_keys("Sound"):
		soundSettings[key] = newConfig.get_value("Sound", key)
	return soundSettings

func saveKeybindSettings(key: String, value):
	newConfig.set_value("Keybinds", key, value)

func loadKeybindSettings():
	var keybindSettings = {}
	for key in newConfig.get_section_keys("Keybinds"):
		keybindSettings[key] = newConfig.get_value("Keybinds", key)
	return keybindSettings

func writeConfigToDisk():
	newConfig.save(SETTINGS_FILE_PATH)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
