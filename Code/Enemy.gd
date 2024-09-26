extends Sprite2D


var options: Array[String] = ["Rock", "Paper", "Scissors"]
var choice: String = options.pick_random()
var pastChoice: String = options.pick_random()


const base_path: String = "res://Assets/Default/Conveyor/"
var choice_paths: Dictionary = {
	"Rock": "Rock/",
	"Paper": "Paper/",
	"Scissors": "Scissors/"
}


const transition_texture = preload(base_path + "RPS_Transition.png")
var frame_counts: Dictionary = { "Rock": 4, "Paper": 6, "Scissors": 6 }


var preloaded_textures: Dictionary = {
	"Rock": [
		preload(base_path + "Rock/rock_in_1.png"),
		preload(base_path + "Rock/rock_in_2.png"),
		preload(base_path + "Rock/rock_in_3.png"),
		preload(base_path + "Rock/rock_in_4.png"),
		preload(base_path + "Rock/rock_idle.png")
	],
	"Paper": [
		preload(base_path + "Paper/paper_in_1.png"),
		preload(base_path + "Paper/paper_in_2.png"),
		preload(base_path + "Paper/paper_in_3.png"),
		preload(base_path + "Paper/paper_in_4.png"),
		preload(base_path + "Paper/paper_in_5.png"),
		preload(base_path + "Paper/paper_in_6.png"),
		preload(base_path + "Paper/paper_idle.png")
	],
	"Scissors": [
		preload(base_path + "Scissors/scissors_in_1.png"),
		preload(base_path + "Scissors/scissors_in_2.png"),
		preload(base_path + "Scissors/scissors_in_3.png"),
		preload(base_path + "Scissors/scissors_in_4.png"),
		preload(base_path + "Scissors/scissors_in_5.png"),
		preload(base_path + "Scissors/scissors_in_6.png"),
		preload(base_path + "Scissors/scissors_idle.png")
	]
}


var preloaded_textures_out: Dictionary = {
	"Rock": [
		preload(base_path + "Rock/rock_out_1.png"),
		preload(base_path + "Rock/rock_out_2.png"),
		preload(base_path + "Rock/rock_out_3.png"),
		preload(base_path + "Rock/rock_out_4.png"),
		preload(base_path + "Rock/rock_out_5.png"),
		preload(base_path + "Rock/rock_out_6.png")
	],
	"Paper": [
		preload(base_path + "Paper/paper_out_1.png"),
		preload(base_path + "Paper/paper_out_2.png"),
		preload(base_path + "Paper/paper_out_3.png"),
		preload(base_path + "Paper/paper_out_4.png"),
		preload(base_path + "Paper/paper_out_5.png"),
		preload(base_path + "Paper/paper_out_6.png")
	],
	"Scissors": [
		preload(base_path + "Scissors/scissors_out_1.png"),
		preload(base_path + "Scissors/scissors_out_2.png"),
		preload(base_path + "Scissors/scissors_out_3.png"),
		preload(base_path + "Scissors/scissors_out_4.png"),
		preload(base_path + "Scissors/scissors_out_5.png"),
		preload(base_path + "Scissors/scissors_out_6.png")
	]
}


var fps: int = 12  # Rayan using 12 fps for some reason :skull:

func _ready():
	new_choice()


func update_display() -> void:
	await get_tree().create_timer(0.2).timeout
	await play_leave_animation()
	texture = transition_texture
	await play_animation_frames()
	texture = preloaded_textures[choice].back()


func play_leave_animation() -> void:
	var frame_delay = 1.0 / fps

	for i in range(1,6):
		texture = preloaded_textures_out[pastChoice][i]
		await get_tree().create_timer(frame_delay).timeout


func play_animation_frames() -> void:
	var total_frames = frame_counts.get(choice)
	var frame_delay = 1.0 / fps

	for i in range(total_frames):
		texture = preloaded_textures[choice][i]
		await get_tree().create_timer(frame_delay).timeout


func new_choice() -> void:
	var possible_choices = options.duplicate()
	pastChoice = choice
	while true:
		choice = possible_choices.pick_random()
		if choice != pastChoice:
			break
	update_display()
