extends Sprite2D

var options: Array[String] = ["Rock", "Paper", "Scissors"]
var resoursePrefix: String = "res://Assets/Placeholder/"
var choice: String = options.pick_random()


func _process(_delta):
	if choice == "Rock":
		change_texture("rock.png")
	elif choice == "Paper":
		change_texture("paper.png")
	elif choice == "Scissors":
		change_texture("scissors.png")


func change_texture(new_path: String) -> void:
	var new_texture: Texture2D = load(resoursePrefix+new_path)
	if new_texture:
		texture = new_texture