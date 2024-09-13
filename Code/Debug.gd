extends Node2D


func _ready():
	%Debug_AutoPlay.button_pressed = Globals.debug_autoplay
	%Debug_StopTime.button_pressed = Globals.debug_stoptime
	%Debug_ResourcePath.text = %Enemy.resourcePrefix


func _input(event):
	if event.is_action_pressed("debug_toggle") && Globals.debug_enabled:
		visible = !visible


func _on_debug_score_set_pressed():
	var score: int = 0
	score = %Debug_ScoreIn.text.to_int()
	%Player.score = score
	%Player.update_score()


func _on_debug_stop_time_pressed():
	Globals.debug_stoptime = !Globals.debug_stoptime


func _on_debug_auto_play_pressed():
	Globals.debug_autoplay = !Globals.debug_autoplay


func _on_debug_skip_round_pressed():
	%Player.logic()


func _on_debug_countdown_set_pressed():
	var time: int = 10
	time = %Debug_CountdownIn.text.to_int()
	%Countdown.INITIAL_TIME = time


func _on_debug_selection_swap_pressed():
	%Countdown.selection_swap()


func _on_debug_resource_path_set_pressed():
	%Enemy.resourcePrefix = %Debug_ResourcePath.text
	%Player.update_selection_images()
	%Enemy.reload_texture()