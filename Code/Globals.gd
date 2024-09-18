extends Node

const easy_theme = "res://Music/easy_mode_placeholder.ogg"
const normal_theme = "res://Music/normal_mode_placeholder.ogg"
const hard_theme = "res://Music/hard_mode.ogg"
const custom_theme = null

enum difficulties { easy, normal, hard, custom, unset }
var difficulty: difficulties = difficulties.unset

var fps_goal: float = DisplayServer.screen_get_refresh_rate()
var debug_enabled: bool = true
var debug_stoptime: bool = false
var debug_autoplay: bool = false
var multiplayer_host: String = "https://awesnap.dev/"
var multiplayer_username: String = "undefined"
var feedback_welcome: bool = true
var feedback_url: String = "https://forms.gle/Ws9qj8pPWxE9waaRA"
var resource_path: String = "res://Assets/Default/"
var default_resource_path: String = resource_path

var global_audio: float = 0.5

func quit():
	if OS.get_name() == "Web":
		set_scene("res://Scenes/web_close.tscn")
	get_tree().quit()


func set_scene(scenePath: String):
	get_tree().change_scene_to_file(scenePath)


func _ready():
	if fps_goal == -1.0:
		fps_goal = 60.0
	Engine.max_fps = int(fps_goal)
	print(Engine.max_fps)
