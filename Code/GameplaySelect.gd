extends Node2D


func _ready():
	if Globals.mode == Globals.gamemode.default:
		$Mode_Select/RPS_Mode.button_pressed = true
		$Mode_Select/Zuckerberg_Mode.button_pressed = false
	elif Globals.mode == Globals.gamemode.lizard_hunter:
		$Mode_Select/RPS_Mode.button_pressed = false
		$Mode_Select/Zuckerberg_Mode.button_pressed = true
	else:
		$Mode_Select/RPS_Mode.button_pressed = true


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
		$Mode_Select/Zuckerberg_Mode.button_pressed = false
	else:
		Globals.mode = Globals.gamemode.lizard_hunter
		$Mode_Select/Zuckerberg_Mode.button_pressed = true


func _on_zuckerberg_mode_toggled(toggled_on:bool):
	if toggled_on:
		Globals.mode = Globals.gamemode.lizard_hunter
		$Mode_Select/RPS_Mode.button_pressed = false
	else:
		Globals.mode = Globals.gamemode.default
		$Mode_Select/RPS_Mode.button_pressed = true


func _on_consent_continue_pressed() -> void:
	Globals.set_scene("res://Scenes/main.tscn")
