extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible


func _on_quit_pressed():
	get_tree().quit()


func _on_mainmenu_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
