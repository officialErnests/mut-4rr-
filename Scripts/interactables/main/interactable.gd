extends Node

enum type {
	SLIDE_DOOR,
	HINGE_DOOR,
	BUTTON,
	SWITCH
}

@export var usecase = type.HINGE_DOOR
@export var main_node: Node3D
@export var move_vector:= Vector3.ZERO
@export var max_action_timer := 10
@export var move_node: Node3D
var action_timer = 0
var active = false
var start_position
var activated = false
var key = 0

func _ready():
	key = get_parent().key
	refresh()

func refresh():
	start_position = move_node.position

func _process(delta: float) -> void:
	if action_timer <= 0: return
	action_timer -= delta

	#So last position is accurate 0
	if action_timer <= 0: 
		action_timer = 0
		activated = false

	match usecase:
		type.SLIDE_DOOR:
			sliderDoor()			

func triggered(p_params):
	if activated: return 
	if key != 0:
		if not p_params.has("door_key") or p_params["door_key"] != key: return
	action_timer = max_action_timer
	active = not active
	activated = true

func sliderDoor():
	var temp_ruler = action_timer / max_action_timer
	temp_ruler *= 1 if active else -1 
	temp_ruler = (0 if active else 1) + temp_ruler
	move_node.position = start_position * temp_ruler + (start_position + move_vector) * (1 - temp_ruler)
