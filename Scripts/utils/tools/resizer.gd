@tool
class_name NB_resizer extends Area3D

@export var key := 0

@export var size := Vector3.ONE:
	set(new_size):
		size = new_size
		resize()

@export var resize_shape_arr: Array[CollisionShape3D]
@export var resize_mesh_arr: Array[MeshInstance3D]

func _ready() -> void:
	resize()

func resize():
	for iter_shape in resize_shape_arr: iter_shape.shape.size = size
	for iter_mesh in resize_mesh_arr: iter_mesh.mesh.size = size