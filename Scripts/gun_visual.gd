extends Node

@export_group("assignments")
@export var LOOK_AT: Node3D
@export var GUN: Node3D
@export var POINTER: Label3D
@export var POINTER_LEFT: Label3D
@export var POINTER_GOAL: MeshInstance3D
@export var POINTER_GROUND: MeshInstance3D
@export var POINTER_GROUND_NORM: MeshInstance3D
@export_group("others")
@export var smoothing: float = 1
var prev_location = Vector3.FORWARD
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	POINTER.scroll_dir = -10
	POINTER_LEFT.scroll_dir = -10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Smooths cursor
	prev_location += (LOOK_AT.global_position - prev_location) * delta * smoothing

	#Detects if there aren't no obstacles infront
	var temp_raycast = castRay()
	var look_position = prev_location
	if temp_raycast:
		look_position = temp_raycast["position"]

	var dist = GUN.global_position.distance_to(look_position)

	GUN.look_at(look_position)

	POINTER_GOAL.global_position = look_position

	POINTER.distance = dist
	POINTER.renderText()
	POINTER.position.z = -0.4 + dist / -2
	POINTER_LEFT.distance = dist
	POINTER_LEFT.renderText()
	POINTER_LEFT.position.z = -0.4 + dist / -2

func castRay():
	var ray_point_start = GUN.global_position
	var ray_point_end = prev_location

	var space_state = GUN.get_world_3d().direct_space_state

	var params = PhysicsRayQueryParameters3D.create(ray_point_start, ray_point_end, 2)

	return space_state.intersect_ray(params)
