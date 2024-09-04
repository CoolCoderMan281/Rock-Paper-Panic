extends Sprite2D

const repeats: int = 2  # Maximum number of consecutive repeats allowed
var options: Array[String] = ["Rock", "Paper", "Scissors"]
var resourcePrefix: String = "res://Assets/Placeholder/"
var choice: String
var pastChoices: Array[String] = []

func _ready():
	new_choice()


func update_display():
	if choice == "Rock":
		change_texture("rock.png")
	elif choice == "Paper":
		change_texture("paper.png")
	elif choice == "Scissors":
		change_texture("scissors.png")


func change_texture(new_path: String):
	var new_texture: Texture2D = load(resourcePrefix + new_path)
	if new_texture:
		texture = new_texture


func new_choice():
	var possible_choices = options.duplicate()
	while true:
		choice = possible_choices.pick_random()
		if !repeat_detector(choice):
			break

	pastChoices.append(choice)
	if pastChoices.size() > repeats:
		pastChoices.pop_back()

	update_display()


func repeat_detector(next_choice: String) -> bool:
	var consecutive_count = 0
	for i in range(pastChoices.size() - 1, -1, -1):
		if pastChoices[i] == next_choice:
			consecutive_count += 1
			if consecutive_count >= repeats:
				return true
		else:
			break
	return false
