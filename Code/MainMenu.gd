extends Node

var fullscreen = false
var windowed = true
var volumeCoverSizeX = 0
var volumeCoverPosX = 0
var speed: float = 700
var min_y: float = -350
var max_y: float = -1100

func _ready():
	if Globals.debug_enabled:
		print("Debug Mode is Enabled!")
		%DebugNotice.visible = true
	%Feedback.visible = Globals.feedback_welcome
	volumeCoverSizeX = %Volume_Cover.size.x
	volumeCoverPosX = %Volume_Cover.position.x
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen = false
		windowed = true
	else:
		fullscreen = true
		windowed = false
	_on_volume_value_changed(%Volume.value)
	AudioServer.set_bus_volume_db(0, Globals.global_audio)
	if Globals.client_type == Globals.client_types.Web:
		speed /= 2


func _on_play_pressed():
	Globals.set_scene("res://Scenes/gameplayselect.tscn")


func _on_quit_pressed():
	Globals.quit()


func _on_back_pressed():
	%Settings.hide()
	Globals.global_audio = AudioServer.get_bus_volume_db(0)


func _on_settings_to_pressed():
	%Settings.show()
	%Volume.value = Globals.global_audio 


func _on_volume_value_changed(value:float):
	%Volume_Label.text = "Volume: " + str(value * 100) + "%"
	AudioServer.set_bus_volume_db(0, value)
	Globals.global_audio = AudioServer.get_bus_volume_db(0)
	%Volume_Cover.size.x = volumeCoverSizeX-(volumeCoverSizeX*value)
	%Volume_Cover.position.x = volumeCoverPosX+(volumeCoverSizeX*value)


func _on_lever_button_pressed():
	# Move to Windowed Mode
	if windowed == false and fullscreen == true:
		fullscreen = false
		windowed = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		%lever.flip_v = false
		
	# Move to Fullscreen Mode
	elif windowed == true and fullscreen == false:
		fullscreen = true
		windowed = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		%lever.flip_v = true


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


func _on_settings_pressed():
	%Settings.show()
	%Volume.value = Globals.global_audio 


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_movement = event.relative
		var new_position = $Clipboard.position
		new_position.y -= mouse_movement.y * speed * get_process_delta_time()
		new_position.y = clamp(new_position.y, max_y, min_y)
		$Clipboard.position = new_position


func _on_tutorial_pressed() -> void:
	pass


func _on_back_2_pressed() -> void:
	$Credits.hide()


func _on_credits_pressed() -> void:
	$Credits.show()
