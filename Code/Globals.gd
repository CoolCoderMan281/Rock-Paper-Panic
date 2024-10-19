extends Node

enum difficulties { easy, normal, hard, custom, unset }
var difficulty: difficulties = difficulties.unset
enum gamemode { default, lizard_hunter, unset }
var mode: gamemode = gamemode.unset
enum client_types { Windows, macOS, Linux, Web, unset }
var client_type: client_types = client_types.unset
var client_uuid: String
var mainmenu_theme: AudioStreamMP3 = preload("res://Assets/Default/Music/mainmenu_theme.mp3")
var rpp_hard_theme: AudioStreamMP3 = preload("res://Assets/Default/Music/rpp_hard_theme.mp3")
var rpp_normal_theme: AudioStreamMP3 = preload("res://Assets/Default/Music/rpp_normal_theme.mp3")
var selection_theme: AudioStreamMP3 = preload("res://Assets/Default/Music/selection_theme.mp3")
var lose_theme: AudioStreamMP3 = preload("res://Assets/Default/Music/rpp_lose.mp3")
var sfx_conveyor: AudioStreamMP3 = preload("res://Assets/Default/SFX/conveyor.mp3")
var sfx_press: AudioStreamMP3 = preload("res://Assets/Default/SFX/press.mp3")
var sfx_switch: AudioStreamMP3 = preload("res://Assets/Default/SFX/switch.mp3")
var sfx_lose: AudioStreamMP3 = preload("res://Assets/Default/SFX/lose_sfx.mp3")
var sfx_muffle: AudioEffect = AudioEffectLowPassFilter.new()

var fps_goal: float = DisplayServer.screen_get_refresh_rate()
var debug_enabled: bool = true
var debug_stoptime: bool = false
var debug_autoplay: bool = false
var feedback_welcome: bool = true
var telemetry_url: String = "https://awesnap.dev/telemetry"
var feedback_url: String = "https://forms.gle/Ws9qj8pPWxE9waaRA"
var resource_path: String = "res://Assets/Default/"
var default_resource_path: String = resource_path
var volume: float = -7.5

func quit():
	if OS.get_name() == "Web":
		JavaScriptBridge.eval("window.close()")
		set_scene("res://Scenes/web_close.tscn")
	get_tree().quit()


func set_scene(scenePath: String):
	get_tree().change_scene_to_file(scenePath)


func generate_uuid() -> String:
	var random = RandomNumberGenerator.new()
	random.randomize()
	var bytes = PackedByteArray()
	for i in range(16):
		bytes.append(random.randi() & 0xFF)
	bytes[6] = (bytes[6] & 0x0F) | 0x40 # UUID version 4 (0100)
	bytes[8] = (bytes[8] & 0x3F) | 0x80 # Variant (1000xxxx)
	var uuid = ""
	for i in range(16):
		uuid += String("%02x" % bytes[i])
		if i in [3, 5, 7, 9]:
			uuid += "-"
	return uuid


func generic_telemetry(name: String, value: String):
	var telemetry = {"name": name, "value": value, "client_uuid":client_uuid}
	var http = HTTPRequest.new()
	add_child(http)
	var http_headers = ["Content-Type: application/json"]
	http.request(telemetry_url,http_headers,HTTPClient.METHOD_POST,JSON.stringify(telemetry))


func _ready():
	client_uuid = generate_uuid()
	if fps_goal == -1.0:
		fps_goal = 60.0
	Engine.max_fps = int(fps_goal)
	AudioServer.set_bus_volume_db(0, volume)
	match OS.get_name():
		"Windows":
			client_type = client_types.Windows
		"macOS":
			client_type = client_types.macOS
		"Linux":
			client_type = client_types.Linux
		"Web":
			client_type = client_types.Web
	var telemetry = {"client_uuid":client_uuid,"client_type":OS.get_name(),
					"fps_goal":fps_goal,"debug_enabled":debug_enabled}
	var http = HTTPRequest.new()
	add_child(http)
	var http_headers = ["Content-Type: application/json"]
	http.request(telemetry_url,http_headers,HTTPClient.METHOD_POST,JSON.stringify(telemetry))
	mainmenu_theme.loop = true
	rpp_hard_theme.loop = true
	rpp_normal_theme.loop = true
	selection_theme.loop = true
	lose_theme.loop = true
