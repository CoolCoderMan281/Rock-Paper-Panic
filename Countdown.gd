extends CanvasLayer


@onready var second = $Second
@onready var timer = $Timer
@onready var player = $/root/Main/Player
@onready var lose_screen = $/root/Main/Lose
@onready var countdown = $/root/Main/Countdown
var time = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()


func _on_timer_timeout():
	time = time - 1
	$Second.text = str(time)
	if time == 0:
		timer.stop()
		player.game_state = "lose"
		player.score = 0
		countdown.visible = false
		lose_screen.visible = true
	if player.game_state == "win":
		time = 3
		$Second.text = str(time)
		timer.start()
		player.game_state = null
	if player.game_state == "lose":
		countdown.visible = false
		timer.stop()
		player.game_state = null
	


func _on_button_pressed():
	time = 3
	countdown.visible = true
	$Second.text = str(time)
	player.game_state = null
	timer.start()

