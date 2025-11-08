extends Node

@export var enabled = false
@export_group("assignments")
@export var LOOK_AT: Node3D
@export var GUN: Node3D
@export var POINTER: Label3D
@export var POINTER_LEFT: Label3D
@export var POINTER_GOAL: MeshInstance3D
@export var POINTER_GROUND: MeshInstance3D
@export var POINTER_GROUND_NORM: Node3D
@export_group("others")
@export var smoothing: float = 1
@export var below_cursor_distance = 2
var prev_location = Vector3.FORWARD
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	POINTER.scroll_dir = -10
	POINTER_LEFT.scroll_dir = -10

func instaSet():
	prev_location = LOOK_AT.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not enabled: return
	#Smooths cursor
	prev_location += (LOOK_AT.global_position - prev_location) * delta * smoothing
	prev_location.y = LOOK_AT.global_position.y
	#Detects if there aren't no obstacles infront
	var temp_raycast = castRay(GUN.global_position, prev_location, GUN.get_world_3d().direct_space_state, 2)
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

	var cursor_raycast = castRay(look_position, look_position - Vector3(0, below_cursor_distance, 0), GUN.get_world_3d().direct_space_state, 4)
	if cursor_raycast:
		POINTER_GROUND_NORM.global_position = cursor_raycast["position"] + Vector3.UP * 0.2
		POINTER_GROUND_NORM.look_at(POINTER_GROUND_NORM.global_position + cursor_raycast["normal"])
		POINTER_GROUND_NORM.rotate_object_local(Vector3.LEFT, (PI / 2))

		var ground_distance = look_position.distance_to(cursor_raycast["position"])
		POINTER_GROUND.mesh.height = ground_distance
		POINTER_GROUND.global_position = (cursor_raycast["position"] + look_position) / 2
		POINTER_GROUND.global_rotation = Vector3.ZERO


func castRay(from, to, obj, coll_layer):
	var params = PhysicsRayQueryParameters3D.create(from, to, coll_layer)

	return obj.intersect_ray(params)
