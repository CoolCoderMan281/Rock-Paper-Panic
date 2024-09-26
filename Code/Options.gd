extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		Globals.debug_stoptime = visible


func _on_quit_pressed():
	Globals.quit()


func _on_mainmenu_pressed():
	Globals.set_scene("res://Scenes/mainmenu.tscn")
