extends WorldEnvironment

var preload_world_env = preload("res://Assets/game_world_env.tres")
var preload_camera_env = preload("res://Scenes/game_world_cam.tres")

func _init() -> void:
	environment = preload_world_env
	camera_attributes = preload_camera_env