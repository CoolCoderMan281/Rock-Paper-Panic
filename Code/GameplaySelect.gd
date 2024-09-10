extends Node2D


func _on_easy_pressed() -> void:
	Globals.difficulty = Globals.difficulties.easy
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_normal_pressed() -> void:
	Globals.difficulty = Globals.difficulties.normal
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_hard_pressed() -> void:
	Globals.difficulty = Globals.difficulties.hard
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
