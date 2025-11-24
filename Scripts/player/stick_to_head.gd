extends Node

@export var skeleton_info: Node
@export var node_to_stick: Node3D
@export var offset: Vector3
func _process(_delta: float) -> void:
	node_to_stick.global_position = skeleton_info.getHeadTrans() + offset
