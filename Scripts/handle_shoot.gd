extends Node

@export var light: Node3D
@export var light_pt2: Node3D
@export var hiddens: Node3D
var timer = 0
var flash_timer = 0
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		light.visible = true
		light_pt2.visible = true
		hiddens.visible = false
		flash_timer = 0.05
		timer = 0.05
	elif flash_timer > 0:
		flash_timer -= delta
	elif timer > 0:
		light_pt2.visible = false
		timer -= delta
	else:
		light_pt2.visible = false
		light.visible = false
		hiddens.visible = true