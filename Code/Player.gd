extends Node2D

var score: int = 0
var pressed_timer: Timer
var can_press: bool = true
var sfx = AudioStreamPlayer.new()
var queued_lose_option = ""

func _ready() -> void:
	%Factory_Background.play("default")
	score = 0
	update_score()
	add_child(sfx)
	sfx.volume_db = Globals.volume
	pressed_timer = Timer.new()
	pressed_timer.set_wait_time(0.5)
	pressed_timer.one_shot = true
	add_child(pressed_timer)
	pressed_timer.connect("timeout", Callable(self,"update_selection_images"))
	%Countdown_2.play("default")
	

func visual_pressed(button: String):
	if button == "Rock":
		%Rock.play("press",true)
	elif button == "Paper":
		%Paper.play("press")
	elif button == "Scissors":
		%Scissors.play("press")
	elif button == "Lizard":
		%Lizard.play("press")
	elif button == "Hunter":
		%Hunter.play("press")
	
	pressed_timer.start()

func logic(choice: String = ""):
	if !can_press:
		return
	if %Lose.visible:
		if choice == "Rock":
			queued_lose_option = "retry"
		elif choice == "Paper":
			queued_lose_option = "mainmenu"
		elif choice == "Scissors":
			queued_lose_option = "quit"
		else:
			return
		var objects = [%Rock, %Paper, %Scissors, %Lizard, %Hunter]
		for obj in objects:
			obj.play("end_end_game")
		return
	visual_pressed(choice)
	sfx.stream = Globals.sfx_press
	sfx.play()

	var outcomes = {
		"Rock": ["Scissors", "Lizard"],
		"Scissors": ["Paper", "Lizard"],
		"Paper": ["Rock", "Hunter"],
		"Lizard": ["Hunter", "Paper"],
		"Hunter": ["Scissors", "Rock"]
	}

	var enemy_choice = %Enemy.choice

	if choice != "":
		if choice in outcomes and enemy_choice in outcomes[choice]:
			score += 1
			%Enemy.new_choice()
			%Countdown.reset_timer()
		elif enemy_choice in outcomes and choice in outcomes[enemy_choice]:
			%Countdown.end_game("lose")
			lose_music()
	else:
		score += 1
		%Enemy.new_choice()
		%Countdown.reset_timer()

	update_score()

func update_score():
	%Score.text = str(score)
	%Final_Score.text = "FINAL SCORE: \n" + str(score)

func retry():
	get_tree().reload_current_scene()

func lose_music():
	sfx.stream = Globals.lose_theme
	sfx.play()
	var sfx1 = AudioStreamPlayer.new()
	sfx1.volume_db = Globals.volume
	add_child(sfx1)
	sfx1.stream = Globals.sfx_lose
	sfx1.play()
	%Rock.play("end_game",true)
	%Paper.play("end_game",true)
	%Scissors.play("end_game",true)
	%Lizard.play("end_game",true)
	%Hunter.play("end_game",true)

func _on_main_menu_pressed():
	Globals.set_scene("res://Scenes/mainmenu.tscn")

func _on_quit_pressed():
	Globals.quit()

func _on_rock_trigger_pressed() -> void:
	logic("Rock")

func _on_paper_trigger_pressed() -> void:
	logic("Paper")

func _on_scissors_trigger_pressed() -> void:
	logic("Scissors")

func _on_hunter_trigger_pressed() -> void:
	logic("Hunter")

func _on_lizard_trigger_pressed() -> void:
	logic("Lizard")

func _on_rock_frame_changed() -> void:
	if queued_lose_option == "":
		return
	if %Lose.visible:
		if %Rock.animation == "end_end_game":
			if %Rock.frame == 3:
				if queued_lose_option == "retry":
					retry()
				elif queued_lose_option == "mainmenu":
					_on_main_menu_pressed()
				elif queued_lose_option == "quit":
					_on_quit_pressed()


func _on_countdown_2_animation_finished():
	%Countdown_2.visible = false
	var objects = [%Rock, %Paper, %Scissors, %Lizard, %Hunter]
	%Countdown.start_music()
	for obj in objects:
		obj.play("appear")
