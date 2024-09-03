extends Node2D


var input
var loss = false
var game_state
var score = 0


func _on_rock_pressed():
	input = "Rock"
	if %Enemy.choice == "Paper":
		game_state = "lose"
		%Lose.visible = true
		score = 0
		%Score.text = "Score: " + str(score)
	elif %Enemy.choice == "Scissors":
		game_state = "win"
		score = score + 1
		%Score.text = "Score: " + str(score)
		%Enemy.choice = %Enemy.options.pick_random()
		print(score)
	else:
		game_state = "tie"
	print(game_state)
	


func _on_paper_pressed():
	input = "Paper"
	if %Enemy.choice == "Scissors":
		game_state = "lose"
		%Lose.visible = true
		score = 0
		%Score.text = str(score)
	elif %Enemy.choice == "Rock":
		game_state = "win"
		score = score + 1
		%Score.text = "Score: " + str(score)
		%Enemy.choice = %Enemy.options.pick_random()
	else:
		game_state = "tie"
	print(game_state)
	print(score)

func _on_scissors_pressed():
	input = "Scissors"
	if %Enemy.choice == "Rock":
		game_state = "lose"
		%Lose.visible = true
		score = 0
		%Score.text = str(score)
	elif %Enemy.choice == "Paper":
		game_state = "win"
		score = score + 1
		%Score.text = "Score: " + str(score)
		%Enemy.choice = %Enemy.options.pick_random()
		print(%Enemy.choice)
	else:
		game_state = "tie"
	print(game_state)
	print(score)
