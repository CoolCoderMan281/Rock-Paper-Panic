extends CanvasLayer

var time = 3

func _on_timer_timeout():
	time -= 1
	%Second.text = str(time)
	if time == 0:
		end_game("lose")
	elif %Player.game_state == "win":
		reset_game()

func _on_button_pressed():
	reset_game()

func end_game(state: String):
	%Countdown_Timer.stop()
	%Player.game_state = state
	%Countdown.visible = false
	%Lose.visible = (state == "lose")

func reset_game():
	time = 3
	%Second.text = str(time)
	%Countdown.visible = true
	%Player.game_state = null
	%Countdown_Timer.start()