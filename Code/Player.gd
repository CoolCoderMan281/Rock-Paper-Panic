extends Node2D


var input
var loss = false
var game_state
var score = 0
@onready var lose_screen = $/root/Main/Lose
@onready var enemy = $/root/Main/Enemy
@onready var score_text = $/root/Main/Score


func _on_rock_pressed():
	input = "Rock"
	if enemy.choice == "Paper":
		game_state = "lose"
		lose_screen.visible = true
		score = 0
		score_text.text = "Score: " + str(score)
	elif enemy.choice == "Scissors":
		game_state = "win"
		score = score + 1
		score_text.text = "Score: " + str(score)
		enemy.choice = enemy.options.pick_random()
		print(score)
	else:
		game_state = "tie"
	print(game_state)
	


func _on_paper_pressed():
	input = "Paper"
	if enemy.choice == "Scissors":
		game_state = "lose"
		lose_screen.visible = true
		score = 0
		score_text.text = str(score)
	elif enemy.choice == "Rock":
		game_state = "win"
		score = score + 1
		score_text.text = "Score: " + str(score)
		enemy.choice = enemy.options.pick_random()
	else:
		game_state = "tie"
	print(game_state)
	print(score)

func _on_scissors_pressed():
	input = "Scissors"
	if enemy.choice == "Rock":
		game_state = "lose"
		lose_screen.visible = true
		score = 0
		score_text.text = str(score)
	elif enemy.choice == "Paper":
		game_state = "win"
		score = score + 1
		score_text.text = "Score: " + str(score)
		enemy.choice = enemy.options.pick_random()
		print(enemy.choice)
	else:
		game_state = "tie"
	print(game_state)
	print(score)
	
func _process(delta):
	pass
