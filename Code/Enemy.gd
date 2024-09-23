extends Sprite2D


var options: Array[String] = ["Rock", "Paper", "Scissors"]
var choice: String
var pastChoice: String


const base_path: String = "res://Assets/Default/Conveyor/"
var choice_paths: Dictionary = {
	"Rock": "Rock/",
	"Paper": "Paper/",
	"Scissors": "Scissors/"
}


const transition_texture = preload(base_path + "RPS_Transition.png")
var frame_counts: Dictionary = { "Rock": 3, "Paper": 5, "Scissors": 5 }


var preloaded_textures: Dictionary = {
	"Rock": [
		preload(base_path + "Rock/rock_in_1.png"),
		preload(base_path + "Rock/rock_in_2.png"),
		preload(base_path + "Rock/rock_in_3.png"),
		preload(base_path + "Rock/rock_idle.png")
	],
	"Paper": [
		preload(base_path + "Paper/paper_in_1.png"),
		preload(base_path + "Paper/paper_in_2.png"),
		preload(base_path + "Paper/paper_in_3.png"),
		preload(base_path + "Paper/paper_in_4.png"),
		preload(base_path + "Paper/paper_in_5.png"),
		preload(base_path + "Paper/paper_idle.png")
	],
	"Scissors": [
		preload(base_path + "Scissors/scissors_in_1.png"),
		preload(base_path + "Scissors/scissors_in_2.png"),
		preload(base_path + "Scissors/scissors_in_3.png"),
		preload(base_path + "Scissors/scissors_in_4.png"),
		preload(base_path + "Scissors/scissors_in_5.png"),
		preload(base_path + "Scissors/scissors_idle.png")
	]
}


var fps: int = 12  # Rayan using 12 fps for some reason :skull:

func _ready():
	new_choice()


func update_display() -> void:
	texture = transition_texture
	await get_tree().create_timer(0.2).timeout
	await play_animation_frames()
	texture = preloaded_textures[choice].back()


func play_animation_frames() -> void:
	var total_frames = frame_counts.get(choice)
	var frame_delay = 1.0 / fps
	

	for i in range(total_frames):
		texture = preloaded_textures[choice][i]
		await get_tree().create_timer(frame_delay).timeout


func new_choice() -> void:
	var possible_choices = options.duplicate()
	while true:
		choice = possible_choices.pick_random()
		if choice != pastChoice:
			break

	pastChoice = choice
	update_display()
