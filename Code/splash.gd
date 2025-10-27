extends VideoStreamPlayer

var _is_done := false

func _on_gui_input(event: InputEvent) -> void:
	if _is_done:
		return
	if event is InputEventMouseButton and event.pressed:
		done()
	elif event is InputEventScreenTouch and event.pressed:
		done()
	elif event is InputEventKey and event.pressed:
		done()

func _on_finished() -> void:
	done()

func done() -> void:
	if _is_done:
		return
	_is_done = true
	stop()
	Globals.set_scene("res://Scenes/mainmenu.tscn")
