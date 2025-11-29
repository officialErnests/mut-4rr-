extends Node

@export var from: Node3D
@export var to: Node3D
@export var x := false
@export var y := false
@export var z := false
@export var offset: Vector3
func _process(_delta: float) -> void:
	var mul_vect = Vector3(x, y, z)
	to.rotation_degrees = from.rotation_degrees * mul_vect + offset
