extends Node2D


func _ready() -> void:
	%VectorMode.button_pressed = Globals.resource_path == "res://Assets/Vector/"


func _on_easy_pressed() -> void:
	Globals.difficulty = Globals.difficulties.easy
	$"%Music".set_stream(preload("res://Music/easy_mode_placeholder.ogg"))
	Globals.set_scene("res://Scenes/main.tscn")


func _on_normal_pressed() -> void:
	Globals.difficulty = Globals.difficulties.normal
	$"%Music".set_stream("res://Music/normal_mode_placeholder.ogg")
	Globals.set_scene("res://Scenes/main.tscn")


func _on_hard_pressed() -> void:
	Globals.difficulty = Globals.difficulties.hard
	$"%Music".set_stream("res://Music/hard_mode.ogg")
	Globals.set_scene("res://Scenes/main.tscn")


func _on_back_pressed() -> void:
	Globals.set_scene("res://Scenes/mainmenu.tscn")


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.resource_path = "res://Assets/Vector/"
	else:
		Globals.resource_path = Globals.default_resource_path
