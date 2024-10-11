extends Node2D

var score: int = 0
var pressed_timer: Timer
var can_press: bool = true

var animation_frames: Array = ["up_1", "up_2", "down_1", "down_2"]

func _ready() -> void:
	score = 0
	update_score()
	update_selection_images()
	pressed_timer = Timer.new()
	pressed_timer.set_wait_time(0.5)
	pressed_timer.one_shot = true
	add_child(pressed_timer)
	pressed_timer.connect("timeout", Callable(self,"update_selection_images"))

func visual_pressed(button: String):
	if !can_press:
		return

	var button_texture_path = Globals.resource_path + "Buttons/" + button + "/"

	for frame in animation_frames:
		var texture = load(button_texture_path + frame + ".png")
		match button:
			"Rock":
				%Rock.texture_normal = texture
			"Paper":
				%Paper.texture_normal = texture
			"Scissors":
				%Scissors.texture_normal = texture
			"Lizard":
				%Lizard.texture_normal = texture
			"Hunter":
				%Hunter.texture_normal = texture

	pressed_timer.start()

func logic(choice: String = ""):
	if !can_press:
		return
	visual_pressed(choice)

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
	else:
		score += 1
		%Enemy.new_choice()
		%Countdown.reset_timer()

	update_score()

func update_selection_images():
	%Rock.texture_normal = load(Globals.resource_path + "Buttons/Rock/idle.png")
	%Paper.texture_normal = load(Globals.resource_path + "Buttons/Paper/idle.png")
	%Scissors.texture_normal = load(Globals.resource_path + "Buttons/Scissors/idle.png")
	%Lizard.texture_normal = load(Globals.resource_path + "Buttons/Lizard/idle.png")
	%Hunter.texture_normal = load(Globals.resource_path + "Buttons/Hunter/idle.png")

func update_score():
	%Score.text = str(score)
	%Final_Score.text = "FINAL SCORE: \n" + str(score)

func _on_rock_pressed():
	logic("Rock")

func _on_paper_pressed():
	logic("Paper")

func _on_scissors_pressed():
	logic("Scissors")

func _on_hunter_pressed():
	logic("Hunter")

func _on_lizard_pressed():
	logic("Lizard")

func retry():
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	Globals.set_scene("res://Scenes/mainmenu.tscn")

func _on_quit_pressed():
	Globals.quit()
