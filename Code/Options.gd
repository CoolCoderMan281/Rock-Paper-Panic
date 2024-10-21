extends Node2D


func _input(event):
	if %Lose.visible:
		return
	if event.is_action_pressed("ui_cancel"):
		if !%Countdown_2.visible:
			visible = !visible
			Globals.debug_stoptime = visible
			if visible:
				AudioServer.add_bus_effect(0,Globals.sfx_muffle,0)
			else:
				AudioServer.remove_bus_effect(0,0)


func _on_quit_pressed():
	Globals.quit()


func _on_mainmenu_pressed():
	Globals.set_scene("res://Scenes/mainmenu.tscn")


func _on_resume_pressed() -> void:
	visible = false
	Globals.debug_stoptime = false
	AudioServer.remove_bus_effect(0,0)

func _on_resume_mouse_entered() -> void:
	$Resume.modulate = Color(1,1,1,0.5)

func _on_resume_mouse_exited() -> void:
	$Resume.modulate = Color(1,1,1,1)

func _on_quit_mouse_entered() -> void:
	$Quit.modulate = Color(1,1,1,0.5)

func _on_quit_mouse_exited() -> void:
	$Quit.modulate = Color(1,1,1,1)

func _on_mainmenu_mouse_entered() -> void:
	$Main.modulate = Color(1,1,1,0.5)

func _on_mainmenu_mouse_exited() -> void:
	$Main.modulate = Color(1,1,1,1)
