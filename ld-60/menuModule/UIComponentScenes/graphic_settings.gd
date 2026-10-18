extends Control

@export var resolutionMenu : OptionButton #implemented
@export var screenMenu : OptionButton #implemented
@export var fpsMenu : HSlider #implemented
@export var fpsMenuBox : SpinBox #implemented
@export var uncapFPS : CheckBox #implemented
@export var collapsedFPS : HBoxContainer #implemented
@export var qualityMenu : OptionButton
@export var shadowsMenu : OptionButton
@export var texturesMenu : OptionButton
@export var effectsMenu : OptionButton
@export var hdrMenu : CheckBox #semi implemented
@export var vsyncMenu : OptionButton #implemented

#screenModi dict
var screenModi = { 
	"Borderless Window" : DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN,
	"Fullscreen" : DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	"Window" : DisplayServer.WindowMode.WINDOW_MODE_WINDOWED,
}

#generel graphic settings dict add or change for customization
var qualitySettings = { 
	"Low" : 0,
	"Medium" : 1,
	"High" : 2,
}

#shadow settings dict add or change for customization
var shadowSettings = { 
	"Low" : 0,
	"Medium" : 1,
	"High" : 2,
}

#texture settings dict add or change for customization
var texturesSettings = { 
	"Low" : 0,
	"Medium" : 1,
	"High" : 2,
}

#effects settings dict add or change for customization
var effectsSettings = { 
	"Low" : 0,
	"Medium" : 1,
	"High" : 2,
}

#vsyncModi array
var vsyncModi = [
	"Disabled",
	"Enabled",
	"Adaptive",
	"Mailbox",
]

#resolution dict
var resolutions = {
	# 16:9
	"16:9" : Vector2i(0,0),
	"1280x720": Vector2i(1280, 720),     # HD
	"1366x768": Vector2i(1366, 768),     # Common laptop
	"1600x900": Vector2i(1600, 900),
	"1920x1080": Vector2i(1920, 1080),   # Full HD
	"2560x1440": Vector2i(2560, 1440),   # QHD
	"3200x1800": Vector2i(3200, 1800),   # QHD+
	"3840x2160": Vector2i(3840, 2160),   # 4K UHD
	"5120x2880": Vector2i(5120, 2880),   # 5K
	"7680x4320": Vector2i(7680, 4320),   # 8K

	# 16:10
	"16:10" : Vector2i(0,0),
	"1280x800": Vector2i(1280, 800),
	"1440x900": Vector2i(1440, 900),
	"1680x1050": Vector2i(1680, 1050),
	"1920x1200": Vector2i(1920, 1200),
	"2560x1600": Vector2i(2560, 1600),

	# Ultrawide (21:9)
	"21:9" : Vector2i(0,0),
	"2560x1080": Vector2i(2560, 1080),
	"3440x1440": Vector2i(3440, 1440),
	"3840x1600": Vector2i(3840, 1600),
	"5120x2160": Vector2i(5120, 2160),

	# Super Ultrawide (32:9)
	"32:9" : Vector2i(0,0),
	"3840x1080": Vector2i(3840, 1080),
	"5120x1440": Vector2i(5120, 1440),
	"7680x2160": Vector2i(7680, 2160)
}

#ready function filling dropdowns and setting current settings
func _ready() -> void:
	if resolutionMenu: add_resolutions()
	if screenMenu: add_screenModi()
	if vsyncMenu: add_vsyncModi()
	if hdrMenu: check_hdrAvailability()
	if qualityMenu: add_quality()
	if shadowsMenu: add_shadow()
	if texturesMenu: add_textures()
	if effectsMenu: add_effects()

#filling resolution dropdown
func add_resolutions():
	for r in resolutions:
		if(resolutions.get(r) == Vector2i(0,0)):
			resolutionMenu.add_separator(r)
		else:
			resolutionMenu.add_item(r)

#filling screen modi dropdown
func add_screenModi():
	for r in screenModi:
		screenMenu.add_item(r)

#fill menu with vsync modes
func add_vsyncModi():
	for r in vsyncModi:
		vsyncMenu.add_item(r)

#fill dropdown for quality
func add_quality():
	for r in qualitySettings:
		qualityMenu.add_item(r)

#fill dropdown for shadow
func add_shadow():
	for r in shadowSettings:
		shadowsMenu.add_item(r)

#fill dropdown for textures
func add_textures():
	for r in texturesSettings:
		texturesMenu.add_item(r)

#fill dropdown for effects
func add_effects():
	for r in effectsSettings:
		effectsMenu.add_item(r)

#check if hdr is enabled and supported
func check_hdrAvailability():
	if DisplayServer.window_is_hdr_output_supported():
		pass
	else:
		hdrMenu.button_pressed = false
		hdrMenu.disabled = true

#center window function for after resizing or similar
func centerWindow():
	get_window().move_to_center()
	#old way
	#var monitorCenter = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	#var windowSize = get_window().get_size_with_decorations()
	#get_window().set_position(monitorCenter - windowSize / 2)


#resolution change function
func _on_resolution_menu_item_selected(index: int) -> void:
	var key = resolutionMenu.get_item_text(index)
	DisplayServer.window_set_size(resolutions.get(key))
	centerWindow()

#change screen mode
func _on_screen_menu_item_selected(index: int) -> void:
	var key = screenMenu.get_item_text(index)
	DisplayServer.window_set_mode(screenModi.get(key))

#change vsyncmode
func _on_vsync_menu_item_selected(index: int) -> void:
	if index > 0: 
		Engine.max_fps = 0
		uncapFPS.disabled = true
		collapsedFPS.visible = false
	else:
		uncapFPS.disabled = false
		_on_uncap_fps_toggled(uncapFPS.button_pressed)
	DisplayServer.window_set_vsync_mode(index)


func _on_hdr_box_toggled(toggled_on: bool) -> void:
		DisplayServer.window_request_hdr_output(toggled_on)

#show and hide fps settings option dependent on whether they are capped
func _on_uncap_fps_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		collapsedFPS.visible = true
		Engine.max_fps = fpsMenu.value
	else:
		collapsedFPS.visible = false
		Engine.max_fps = 0


func _on_fps_menu_drag_ended(value_changed: bool) -> void:
	fpsMenuBox.value = fpsMenu.value
	Engine.max_fps = fpsMenu.value
	pass # Replace with function body.


func _on_fps_menu_box_value_changed(value: float) -> void:
	fpsMenu.value = fpsMenuBox.value
	Engine.max_fps = fpsMenuBox.value
	pass # Replace with function body.


#implement as wanted
func _on_quality_menu_item_selected(index: int) -> void:
	pass # Replace with function body.

#implement as wanted
func _on_shadows_menu_item_selected(index: int) -> void:
	pass # Replace with function body.

#implement as wanted
func _on_textures_menu_item_selected(index: int) -> void:
	pass # Replace with function body.

#implement as wanted
func _on_effects_menu_item_selected(index: int) -> void:
	pass # Replace with function body.
