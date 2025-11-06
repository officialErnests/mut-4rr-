extends Node

@export var camera: Camera3D
@export var pointer: Node3D
@export var offset: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var casted_ray = castRay()
	if casted_ray:
		pointer.global_position = casted_ray["position"] + offset
		

func castRay():
	var mouse_position = get_viewport().get_mouse_position()
	var ray_point_start = camera.project_ray_origin(mouse_position)
	var ray_point_end = ray_point_start + camera.project_ray_normal(mouse_position) * 100

	var space_state = camera.get_world_3d().direct_space_state

	var params = PhysicsRayQueryParameters3D.create(ray_point_start, ray_point_end, 2)

	return space_state.intersect_ray(params)
