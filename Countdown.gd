extends CanvasLayer

const INITIAL_TIME: int = 3
var time_left: int = INITIAL_TIME
var last_update_time: float = 0.0

func _ready():
	reset_timer()

func _process(delta: float):
	last_update_time += delta
	if last_update_time >= 1.0:
		last_update_time -= 1.0
		time_left -= 1
		update_display()
		
		if time_left <= 0:
			end_game("lose")

func update_display():
	%Second.text = str(time_left)

func reset_timer():
	time_left = INITIAL_TIME
	last_update_time = 0.0
	update_display()
	%Countdown.visible = true

func end_game(state: String):
	%Countdown.visible = false
	%Lose.visible = (state == "lose")
