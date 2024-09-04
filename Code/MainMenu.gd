extends Node


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	%Settings.hide()


func _on_settings_to_pressed():
	%Settings.show()
