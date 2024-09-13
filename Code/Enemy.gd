extends Sprite2D

var options: Array[String] = ["Rock", "Paper", "Scissors"]
var resourcePrefix: String = "res://Assets/Placeholder/"
var choice: String
var pastChoice: String


func _ready():
	new_choice()


func update_display():
	if choice == "Rock":
		change_texture("rock.png")
	elif choice == "Paper":
		change_texture("paper.png")
	elif choice == "Scissors":
		change_texture("scissors.png")


func reload_texture():
	change_texture(choice.to_lower() + ".png")


func change_texture(new_path: String):
	var new_texture: Texture2D = load(resourcePrefix + new_path)
	if new_texture:
		texture = new_texture


func new_choice():
	var possible_choices = options.duplicate()
	while true:
		choice = possible_choices.pick_random()
		if !pastChoice == choice:
			break

	pastChoice = choice
	update_display()
