extends Node


func _ready() -> void:
	%BackendUrl.text = %BackendUrl.text + Globals.multiplayer_host


func _on_room_join_pressed() -> void:
	pass # Replace with function body.


func _on_create_room_pressed() -> void:
	var server_url = Globals.multiplayer_host+"create_room"
