extends Node2D

var player = AudioStreamPlayer.new()

func _ready():
	add_child(player)
	player.volume_db = Globals.volume
	player.stream = Globals.selection_theme
	player.play()
	if Globals.mode == Globals.gamemode.default:
		$Menu/Buttons/RPS_Mode.button_pressed = true
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = false
	elif Globals.mode == Globals.gamemode.lizard_hunter:
		$Menu/Buttons/RPS_Mode.button_pressed = false
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = true
	else:
		$Menu/Buttons/RPS_Mode.button_pressed = true


func _on_normal_pressed() -> void:
	Globals.difficulty = Globals.difficulties.normal
	Globals.set_scene("res://Scenes/main.tscn")


func _on_hard_pressed() -> void:
	Globals.difficulty = Globals.difficulties.hard
	$Consent_HARD.visible = true


func _on_back_pressed() -> void:
	Globals.set_scene("res://Scenes/mainmenu.tscn")


func _on_rps_mode_toggled(toggled_on:bool):
	if toggled_on:
		Globals.mode = Globals.gamemode.default
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = false
	else:
		Globals.mode = Globals.gamemode.lizard_hunter
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = true


func _on_zuckerberg_mode_toggled(toggled_on:bool):
	if toggled_on:
		Globals.mode = Globals.gamemode.lizard_hunter
		$Menu/Buttons/RPS_Mode.button_pressed = false
	else:
		Globals.mode = Globals.gamemode.default
		$Menu/Buttons/RPS_Mode.button_pressed = true


func _on_consent_continue_pressed() -> void:
	Globals.set_scene("res://Scenes/main.tscn")
