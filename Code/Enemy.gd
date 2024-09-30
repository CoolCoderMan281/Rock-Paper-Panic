extends Sprite2D


var options: Array[String] = ["Rock", "Paper", "Scissors"]
var choice: String = options.pick_random()
var pastChoice: String = options.pick_random()


const base_path: String = "res://Assets/Default/Conveyor/"
var choice_paths: Dictionary = {
	"Rock": "Rock/",
	"Paper": "Paper/",
	"Scissors": "Scissors/",
	"Lizard": "Lizard/",
	"Hunter": "Hunter/"
}


const transition_texture = preload(base_path + "RPS_Transition.png")
var frame_counts: Dictionary = { "Rock": 4, "Paper": 6, "Scissors": 6, "Lizard": 6, "Hunter":6}
var texture_cache: Dictionary = {}

var fps: int = 12  # Rayan using 12 fps for some reason :skull:


func _ready():
	if Globals.mode == Globals.gamemode.lizard_hunter:
		options += ["Lizard", "Hunter"]
		%Lizard.visible = true
		%Hunter.visible = true
	new_choice()


func update_display() -> void:
	await get_tree().create_timer(0.2).timeout
	await play_leave_animation()

	texture = transition_texture
	queue_redraw()
	await get_tree().create_timer(0.2).timeout

	await play_enter_animation()

	texture = get_texture_from_cache(choice, "idle")
	queue_redraw()


func play_leave_animation() -> void:
	var frame_delay = 1.0 / fps
	var total_frames = 6

	for i in range(total_frames):
		texture = get_texture_from_cache(pastChoice, "out_" + str(i + 1))
		queue_redraw()
		await get_tree().create_timer(frame_delay).timeout


func play_enter_animation() -> void:
	var total_frames = frame_counts.get(choice)
	var frame_delay = 1.0 / fps

	for i in range(total_frames):
		texture = get_texture_from_cache(choice, "in_" + str(i + 1))
		queue_redraw()
		await get_tree().create_timer(frame_delay).timeout


func get_texture_from_cache(type: String, frame: String) -> Texture2D:
	if !texture_cache.has(type):
		texture_cache[type] = {}
	
	if !texture_cache[type].has(frame):
		var texture_path = base_path + choice_paths[type] + type.to_lower() + "_" + frame + ".png"
		var new_texture = load(texture_path)
		texture_cache[type][frame] = new_texture
	
	return texture_cache[type][frame]


func new_choice() -> void:
	var possible_choices = options.duplicate()
	pastChoice = choice
	while true:
		choice = possible_choices.pick_random()
		if choice != pastChoice:
			break

	update_display()
