extends Node

const easy_theme = null
const normal_theme = "res://Music/normal_mode_placeholder.ogg"
const hard_theme = "res://Music/hard_mode.ogg"
const custom_theme = null

enum difficulties { easy, normal, hard, custom, unset }
var difficulty: difficulties = difficulties.unset
enum gamemode { default, lizard_hunter, unset }
var mode: gamemode = gamemode.unset
enum client_types { Windows, macOS, Linux, Web, unset }
var client_type: client_types = client_types.unset

var fps_goal: float = DisplayServer.screen_get_refresh_rate()
var debug_enabled: bool = true
var debug_stoptime: bool = false
var debug_autoplay: bool = false
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
	match OS.get_name():
		"Windows":
			client_type = client_types.Windows
		"macOS":
			client_type = client_types.macOS
		"Linux":
			client_type = client_types.Linux
		"Web":
			client_type = client_types.Web
