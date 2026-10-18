extends Control


@export var masterSoundSlider : HSlider 
@export var masterSoundBox : SpinBox 
@export var musicSoundSlider : HSlider 
@export var musicSoundBox : SpinBox 
@export var effectsSoundSlider : HSlider 
@export var effectsSoundBox : SpinBox 
@export var dialogSoundSlider : HSlider 
@export var dialogSoundBox : SpinBox 
@export var voiceSoundSlider : HSlider 
@export var voiceSoundBox : SpinBox 

func _ready() -> void:
	#print(AudioServer.get_bus_volume_linear(0))
	if masterSoundBox && masterSoundSlider: masterSoundBox.value = AudioServer.get_bus_volume_linear(0)*100
	if musicSoundBox && musicSoundSlider: musicSoundBox.value = AudioServer.get_bus_volume_linear(1)*100
	if effectsSoundBox && effectsSoundSlider: effectsSoundBox.value = AudioServer.get_bus_volume_linear(2)*100
	if dialogSoundBox && dialogSoundSlider: dialogSoundBox.value = AudioServer.get_bus_volume_linear(3)*100
	if voiceSoundBox && voiceSoundSlider: voiceSoundBox.value = AudioServer.get_bus_volume_linear(4)*100

func _on_master_sound_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(0,masterSoundSlider.value)
	masterSoundBox.value = masterSoundSlider.value


func _on_music_sound_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(1,musicSoundSlider.value)
	musicSoundBox.value = musicSoundSlider.value


func _on_effects_sound_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(2,effectsSoundSlider.value/100)
	effectsSoundBox.value = effectsSoundSlider.value


func _on_dialog_sound_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(3,dialogSoundSlider.value/100)
	dialogSoundBox.value = dialogSoundSlider.value


func _on_voice_sound_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(4,voiceSoundSlider.value/100)
	voiceSoundBox.value = voiceSoundSlider.value


func _on_master_sound_box_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0,masterSoundBox.value/100)
	masterSoundSlider.value = masterSoundBox.value


func _on_music_sound_box_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(1,musicSoundBox.value/100)
	musicSoundSlider.value = musicSoundBox.value


func _on_effects_sound_box_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(2,effectsSoundBox.value/100)
	effectsSoundSlider.value = effectsSoundBox.value


func _on_dialog_sound_box_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(3,dialogSoundBox.value/100)
	dialogSoundSlider.value = dialogSoundBox.value


func _on_voice_sound_box_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(4,voiceSoundBox.value/100)
	voiceSoundSlider.value = voiceSoundBox.value
