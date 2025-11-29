extends Node

@export var obj: Node3D
@export var space_mul: float = 1
@export var speed_mul: float = 1

func shot(p_intensity):
	obj.position += Vector3(randf_range(-p_intensity, p_intensity), 0, randf_range(-p_intensity, p_intensity))

func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size / 2
	var gotTo = Vector3(mouse_position.x, 0, mouse_position.y) * space_mul
	obj.position += (gotTo - obj.position) * delta * speed_mul
