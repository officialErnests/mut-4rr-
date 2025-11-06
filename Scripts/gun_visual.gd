extends Node

@export var LOOK_AT: Node3D
@export var GUN: Node3D
@export var POINTER: Label3D
@export var POINTER_GOAL: MeshInstance3D
@export var POINTER_GROUND: MeshInstance3D
@export var POINTER_GROUND_NORM: MeshInstance3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GUN.look_at(LOOK_AT.global_position)
	var dist = GUN.global_position.distance_to(LOOK_AT.global_position)
	POINTER.distance = dist
	POINTER.renderText()
	POINTER.position.z = -0.8 + dist / -2
