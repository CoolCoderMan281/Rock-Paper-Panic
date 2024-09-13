extends Node2D

var score: int = 0


func logic(choice: String = ""):
	var outcomes = {"Rock": "Scissors", "Paper": "Rock", "Scissors": "Paper"}
	var enemy_choice = %Enemy.choice
	
	if choice != "":
		if outcomes[choice] == enemy_choice:
			score += 1
			%Enemy.new_choice()
			%Countdown.reset_timer()
		elif outcomes[enemy_choice] == choice:
			score = 0
			%Countdown.end_game("lose")
	else:
		score += 1
		%Enemy.new_choice()
		%Countdown.reset_timer()
	
	update_score()


func update_score():
	%Score.text = "Score: " + str(score)


func _on_rock_pressed():
	logic("Rock")


func _on_paper_pressed():
	logic("Paper")


func _on_scissors_pressed():
	logic("Scissors")


func retry():
	get_tree().reload_current_scene()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")


func _on_quit_pressed():
	get_tree().quit()
