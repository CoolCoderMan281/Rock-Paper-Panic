extends Node


func _ready():
	var required_assets = [
		"res://Assets/Important/DifficultySelect.webp",
		"res://Assets/Important/OhYea.webp",
		"res://Assets/Important/RobloxTycoon.webp",
		"res://Assets/Important/DoubleClick.jpg"
	]
	for asset in required_assets:
		if !FileAccess.file_exists(asset):
			# Crash the game by asserting false
			assert(false, "null")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		%Windowed.disabled = true
		%Fullscreen.disabled = false
		# List of required assets
	else:
		%Windowed.disabled = false
		%Fullscreen.disabled = true


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/gameplayselect.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	%Settings.hide()


func _on_settings_to_pressed():
	%Settings.show()


func _on_volume_value_changed(value:float):
	%Volume_Label.text = "Volume: " + str(value) + "%"
	AudioServer.set_bus_volume_db(0, value)

func _on_windowed_pressed():
	%Windowed.disabled = true
	%Fullscreen.disabled = false
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

	
func _on_fullscreen_pressed():
	%Windowed.disabled = false
	%Fullscreen.disabled = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
