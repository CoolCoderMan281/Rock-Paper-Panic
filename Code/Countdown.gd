extends CanvasLayer

var INITIAL_TIME: int = 10
var time_left: int = INITIAL_TIME
var last_update_time: float = 0.0
var win_tracker:int = -1
var difficulty: String = "unset"
var win_req: int = 0
var timer_min: int = 2
var player = AudioStreamPlayer.new()
var sfx = AudioStreamPlayer.new()
var lh_mode: bool = false

func _ready():
	add_child(player)
	if Globals.mode == Globals.gamemode.lizard_hunter:
		lh_mode = true
	Globals.debug_autoplay = false
	Globals.debug_stoptime = false
	if Globals.difficulty == Globals.difficulties.normal:
		difficulty = "normal"
		win_req = 10
		player.stream = Globals.rpp_normal_theme
	elif Globals.difficulty == Globals.difficulties.hard:
		difficulty = "hard"
		win_req = 5
		INITIAL_TIME = 5
		player.stream = Globals.rpp_hard_theme
	else:
		print("Something has gone seriously wrong, there is no difficulty..")
		win_req = 999
	Globals.generic_telemetry("Difficulty: ",difficulty)
	reset_timer()
	player.volume_db = Globals.volume
	player.play()

func _process(delta: float):
	if !Globals.debug_stoptime:
		last_update_time += delta
		if last_update_time >= 1.0:
			last_update_time -= 1.0
			time_left -= 1
			update_display()
			if time_left <= 0:
				if Globals.debug_autoplay:
					%Player.logic()
				else:
					end_game("lose")

func update_display():
	%Second.text = str(time_left)


func reset_timer():
	time_left = INITIAL_TIME
	last_update_time = 0.0
	update_display()
	%Countdown.visible = true
	# Here we are going to "assume" that they won, as it doesn't reset otherwise anyway..
	win_tracker += 1
	if (win_tracker >= win_req):
		if(INITIAL_TIME > timer_min):
			print("Wins: "+str(win_tracker)+" of: "+str(win_req))
			win_tracker = 0
			INITIAL_TIME -= 1
			print("-1 Second on the timer!")
		# Im cheating!!! Im also applying the option randomizer here MUHAUHAUHA!
		selection_swap()


func selection_swap():
	var objects: Array[AnimatedSprite2D]
	if lh_mode:
		objects = [%Rock, %Paper, %Scissors, %Lizard, %Hunter]
	else:
		objects = [%Rock, %Paper, %Scissors]
	
	for obj in objects:
		obj.play("selection_swap")
	sfx_play(Globals.sfx_switch)

func _on_rock_frame_changed() -> void:
	if %Rock.animation == "selection_swap" and %Rock.frame == 4:
		var objects: Array[AnimatedSprite2D]
		if lh_mode:
			objects = [%Rock, %Paper, %Scissors, %Lizard, %Hunter]
		else:
			objects = [%Rock, %Paper, %Scissors]
		var objectPos: Array[Vector2] = []
		
		for obj in objects: # Steal all positions
			objectPos.append(obj.global_position)
			print(obj.global_position)
		objectPos.shuffle()
		for i in range(objects.size()): # Swap the positions
			objects[i].global_position = objectPos[i]


func end_game(state: String):
	%Countdown.visible = false
	%Lose.visible = (state == "lose")
	%Countdown.queue_free()
	player.stream = Globals.lose_theme
	player.play()
	Globals.generic_telemetry("Final Score: ",str(%Player.score))


func sfx_play(name: AudioStreamMP3):
	sfx.stream = name
	sfx.play()
