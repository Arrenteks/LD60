extends Control


@onready var settings_button: Button = $"Menu Content/SettingsButton"
@onready var credits_button: Button = $"Menu Content/CreditsButton"

@onready var credits: Control = $Credits

func _on_settings_button_pressed() -> void:
	settings_button.release_focus()

func _on_credits_button_pressed() -> void:
	credits.visible = true
	credits_button.release_focus()

func _on_credits_back_2_menu_pressed() -> void:
	credits.visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()
