extends Sprite2D


var options: Array[String] = ["Rock", "Paper", "Scissors"]
var choice: String
var pastChoice: String


var base_path: String = "res://Assets/Default/Conveyor/"
var choice_paths: Dictionary = {
	"Rock": "Rock/",
	"Paper": "Paper/",
	"Scissors": "Scissors/"
}


var transition_texture: String = base_path + "RPS_Transition.png"
var frame_counts: Dictionary = { "Rock": 3, "Paper": 5, "Scissors": 5 }


var fps: int = 12  # Rayan using 12 for some reason :skull:


func _ready():
	new_choice()



func update_display() -> void:
	change_texture(transition_texture)
	await get_tree().create_timer(0.2).timeout
	await play_animation_frames()
	change_texture(base_path + choice_paths.get(choice) + choice.to_lower() + "_idle.png")


func play_animation_frames() -> void: # Plays in_ frames
	var total_frames = frame_counts.get(choice)
	var frame_delay = 1.0 / fps
	
	for i in range(total_frames):
		var frame_path = base_path + choice_paths.get(choice) + choice + "_in_" + str(i + 1) + ".png"
		change_texture(frame_path)
		await get_tree().create_timer(frame_delay).timeout


func change_texture(new_path: String) -> void:
	var new_texture: Texture2D = load(new_path)
	if new_texture:
		texture = new_texture
	else:
		print("Failed to load texture: " + new_path)


func new_choice() -> void:
	var possible_choices = options.duplicate()
	while true:
		choice = possible_choices.pick_random()
		if choice != pastChoice:
			break

	pastChoice = choice
	update_display()
