extends Node

@export var itemHolder: Node3D
@export var animator: Node
@export var pickup_hitbox: Area3D
@export var cursor_handler: Node
@export var cam_shaker: Node
@export var movement_manager: Node

var equiped_item = null
var equiped_item_script = null
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		if equiped_item:
			throw()
		else:
			pickupDetect()

func throw():
	animator.use()
	animator.hold(false)

	equiped_item_script.drop()
	equiped_item.reparent(global.global_nodes["Items"])
	equiped_item.add_to_group("item")

	movement_manager.item_mul = 1

	equiped_item = null
	equiped_item_script = null

func pickupDetect():
	var hit_nodes = pickup_hitbox.get_overlapping_bodies()
	for node in hit_nodes:
		if node.is_in_group("item"):
			pickup(node)
			return

func pickup(p_node: Node):
	animator.use()
	animator.hold(true)
	p_node.reparent(itemHolder)
	equiped_item = p_node
	equiped_item_script = p_node.get_node("MAIN")
	p_node.remove_from_group("item")

	movement_manager.item_mul = equiped_item_script.speed_factor
	equiped_item_script.initalise(self)

func getCursorHandler():
	return cursor_handler

func getCamShaker():
	return cam_shaker
