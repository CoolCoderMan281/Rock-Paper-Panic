extends Node

enum difficulties { easy, normal, hard, unset }
var difficulty: difficulties = difficulties.unset

var debug_enabled: bool = true
var debug_stoptime: bool = false
var debug_autoplay: bool = false
var resource_path: String = "res://Assets/Default/"
var default_resource_path: String = resource_path
