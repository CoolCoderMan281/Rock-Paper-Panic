extends Node2D

var player = AudioStreamPlayer.new()

func _ready():
	add_child(player)
	player.volume_db = Globals.volume
	player.stream = Globals.selection_theme
	player.play()
	if Globals.mode == Globals.gamemode.default:
		$Menu/Buttons/RPS_Mode.button_pressed = true
		$Menu/Graphics/DifficultyRps.modulate = Color(1, 1, 1, 0.5)
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = false
		$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1, 1)
	elif Globals.mode == Globals.gamemode.lizard_hunter:
		$Menu/Buttons/RPS_Mode.button_pressed = false
		$Menu/Graphics/DifficultyRps.modulate = Color(1, 1, 1, 1)
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = true
		$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1, 0.5)
	else:
		$Menu/Buttons/RPS_Mode.button_pressed = true
		$Menu/Graphics/DifficultyRps.modulate = Color(1,1,1, 0.5)


func _on_normal_pressed() -> void:
	Globals.difficulty = Globals.difficulties.normal
	Globals.set_scene("res://Scenes/main.tscn")


func _on_hard_pressed() -> void:
	Globals.difficulty = Globals.difficulties.hard
	Globals.set_scene("res://Scenes/main.tscn")


func _on_back_pressed() -> void:
	Globals.set_scene("res://Scenes/mainmenu.tscn")


func _on_rps_mode_toggled(toggled_on:bool):
	if toggled_on:
		Globals.mode = Globals.gamemode.default
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = false
		$Menu/Graphics/DifficultyRps.modulate = Color(1, 1, 1, 0.5)
		$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1, 1)
	else:
		Globals.mode = Globals.gamemode.lizard_hunter
		$Menu/Buttons/Zuckerberg_Mode.button_pressed = true
		$Menu/Graphics/DifficultyRps.modulate = Color(1, 1, 1, 1)
		$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1, 0.5)


func _on_zuckerberg_mode_toggled(toggled_on:bool):
	if toggled_on:
		Globals.mode = Globals.gamemode.lizard_hunter
		$Menu/Buttons/RPS_Mode.button_pressed = false
		$Menu/Graphics/DifficultyRps.modulate = Color(1, 1, 1, 1)
		$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1, 0.5)
	else:
		Globals.mode = Globals.gamemode.default
		$Menu/Buttons/RPS_Mode.button_pressed = true
		$Menu/Graphics/DifficultyRps.modulate = Color(1, 1, 1, 0.5)
		$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1, 1)


func _on_consent_continue_pressed() -> void:
	$Consent_HARD.visible = false


func _on_contract_pressed():
	$Consent_HARD.visible = true

func _on_back_mouse_entered() -> void:
	$Menu/Graphics/Back.modulate = Color(1,1,1,0.5)

func _on_back_mouse_exited() -> void:
	$Menu/Graphics/Back.modulate = Color(1,1,1,1)

func _on_contract_mouse_entered() -> void:
	$Menu/Graphics/DifficultyContract.modulate = Color(1,1,1,0.5)

func _on_contract_mouse_exited() -> void:
	$Menu/Graphics/DifficultyContract.modulate = Color(1,1,1,1)

#func _on_rps_mode_mouse_entered() -> void:
	#$Menu/Graphics/DifficultyRps.modulate = Color(1,1,1,0.5)
#
#func _on_rps_mode_mouse_exited() -> void:
	#$Menu/Graphics/DifficultyRps.modulate = Color(1,1,1,1)
#
#func _on_zuckerberg_mode_mouse_entered() -> void:
	#$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1,0.5)
#
#func _on_zuckerberg_mode_mouse_exited() -> void:
	#$Menu/Graphics/DifficultyLh.modulate = Color(1,1,1,1)

func _on_normal_mouse_entered() -> void:
	$Menu/Graphics/DifficultyNormal.modulate = Color(1,1,1,0.5)

func _on_normal_mouse_exited() -> void:
	$Menu/Graphics/DifficultyNormal.modulate = Color(1,1,1,1)

func _on_hard_mouse_entered() -> void:
	$Menu/Graphics/DifficultyHard.modulate = Color(1,1,1,0.5)

func _on_hard_mouse_exited() -> void:
	$Menu/Graphics/DifficultyHard.modulate = Color(1,1,1,1)
