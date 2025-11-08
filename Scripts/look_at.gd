extends Node

@export var base: Node3D
@export var look_node: Node3D
@export var offset: Vector3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	base.look_at(look_node.global_position + offset)
