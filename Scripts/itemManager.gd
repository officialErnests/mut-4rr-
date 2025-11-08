extends Node

@export var itemHolder: Node3D
@export var animator: Node
@export var pickup_hitbox: Area3D
@export_group("items")
@export var cursor_handler: Node
@export var cam_shaker: Node

var equiped_item = null
var equiped_item_script = null
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		pickupDetect()

func pickupDetect():
	var hit_nodes = pickup_hitbox.get_overlapping_bodies()
	for node in hit_nodes:
		if node.is_in_group("item"):
			pickup(node)
			return

func pickup(p_node: Node):
	p_node.reparent(itemHolder)
	equiped_item = p_node
	equiped_item_script = p_node.get_node("MAIN")

	equiped_item_script.initalise(self)

func getCursorHandler():
	return cursor_handler

func getCamShaker():
	return cam_shaker
