extends Node2D

var score: int = 0
var pressed_timer: Timer

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
	if button == "Rock":
		%Rock.texture_normal = load(Globals.resource_path+"Buttons/Rock/Center/pressed_rock_center.png")
	elif button == "Paper":
		%Paper.texture_normal = load(Globals.resource_path+"Buttons/Paper/Center/pressed_paper_center.png")
	elif button == "Scissors":
		%Scissors.texture_normal = load(Globals.resource_path+"Buttons/Scissors/Center/pressed_scissors_center.png")
	elif button == "Lizard":
		%Lizard.texture_normal = load(Globals.resource_path+"Buttons/Lizard/Center/pressed_lizard_center.png")
	elif button == "Hunter":
		%Hunter.texture_normal = load(Globals.resource_path+"Buttons/Hunter/Center/pressed_hunter_center.png")

	pressed_timer.start()


func logic(choice: String = ""):
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
			# If there's a tie
			%Countdown.reset_timer()
	else:
		score += 1
		%Enemy.new_choice()
		%Countdown.reset_timer()

	update_score()



func update_selection_images():
	%Rock.texture_normal = load(Globals.resource_path+"Buttons/Rock/Center/rock_center.png")
	%Paper.texture_normal = load(Globals.resource_path+"Buttons/Paper/Center/paper_center.png")
	%Scissors.texture_normal = load(Globals.resource_path+"Buttons/Scissors/Center/scissors_center.png")
	%Lizard.texture_normal = load(Globals.resource_path+"Buttons/Lizard/Center/lizard_center.png")
	%Hunter.texture_normal = load(Globals.resource_path+"Buttons/Hunter/Center/hunter_center.png")


func update_score():
	%Score.text = str(score)
	%Final_Score.text = "FINAL SCORE: \n" + str(score)


func _on_rock_pressed():
	logic("Rock")
	visual_pressed("Rock")


func _on_paper_pressed():
	logic("Paper")
	visual_pressed("Paper")


func _on_scissors_pressed():
	logic("Scissors")
	visual_pressed("Scissors")


func _on_hunter_pressed():
	logic("Hunter")
	visual_pressed("Hunter")


func _on_lizard_pressed():
	logic("Lizard")
	visual_pressed("Lizard")


func retry():
	get_tree().reload_current_scene()


func _on_main_menu_pressed():
	Globals.set_scene("res://Scenes/mainmenu.tscn")


func _on_quit_pressed():
	Globals.quit()
