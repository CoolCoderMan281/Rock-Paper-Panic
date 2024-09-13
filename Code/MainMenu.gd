extends Node

# C:\Users\[USERNAME]\AppData\Roaming\NeededFiles
# var required_assets = {
#		"image1" : "DifficultySelect.webp",
#		"image2" : "OhYea.webp",
#		"image3" : "RobloxTycoon.webp",
#		"image4" : "DoubleClick.jpg"
# }

# for asset in reqired_assets:
# 	if not FileAccess.file_exists("user://", asset):
#		# Crash game... but with COOL OS alert message
# 		OS.alert('BLUD DONT DELETE THOSE IMAGES', 'Alert!')
# 		get_tree().quit()

func _ready():
	if Globals.debug_enabled:
		print("Debug Mode is Enabled!")
		%DebugNotice.visible = true
	%Feedback.visible = Globals.feedback_welcome
	var required_assets = [
		"res://Assets/Important/DifficultySelect.webp",
		"res://Assets/Important/OhYea.webp",
		"res://Assets/Important/RobloxTycoon.webp",
		"res://Assets/Important/DoubleClick.jpg"
	]
	for asset in required_assets:
		if !FileAccess.file_exists(asset):
			assert(false, "null")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		%Windowed.disabled = true
		%Fullscreen.disabled = false
	else:
		%Windowed.disabled = false
		%Fullscreen.disabled = true


func _on_play_pressed():
	Globals.set_scene("res://Scenes/gameplayselect.tscn")


func _on_quit_pressed():
	Globals.quit()


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




func _on_quit_mouse_exited():
	%Quit.modulate = Color(1, 1, 1, 1)


func _on_quit_mouse_entered():
	%Quit.modulate = Color(1, 1, 1, 0.5)


func _on_settings_to_mouse_exited():
	%Settings_To.modulate = Color(1, 1, 1, 1)


func _on_settings_to_mouse_entered():
	%Settings_To.modulate = Color(1, 1, 1, 0.5)

func _on_play_mouse_exited():
	%Play.modulate = Color(1, 1, 1, 1)

func _on_play_mouse_entered():
	%Play.modulate = Color(1, 1, 1, 0.5)


func _on_feedback_pressed() -> void:
	OS.shell_open(Globals.feedback_url)
