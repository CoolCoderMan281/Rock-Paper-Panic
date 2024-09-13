extends Node

enum difficulties { easy, normal, hard, unset }
var difficulty: difficulties = difficulties.unset

var debug_enabled: bool = true
var debug_stoptime: bool = false
var debug_autoplay: bool = false
var feedback_welcome: bool = true
var feedback_url: String = "https://example.com"
var resource_path: String = "res://Assets/Default/"
var default_resource_path: String = resource_path

func quit():
	if OS.get_name() == "Web":
		if OS.has_feature("JavaScript"):
			JavaScriptBridge.eval("window.close()")
	get_tree().quit()
