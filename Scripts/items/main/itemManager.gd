extends Node

@export var itemHolder: Node3D
@export var animator: Node
@export var pickup_hitbox: Area3D
@export var cursor_handler: Node
@export var cam_shaker: Node
@export var movement_manager: Node
# Specificly this project ;))
@export var cursor_label_1 : Label3D
@export var cursor_label_2 : Label3D

var equiped_item = null
var equiped_item_script = null
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		animator.use()
		if equiped_item:
			throw()
		else:
			pickupDetect()
	if Input.is_action_just_pressed("use"):
		animator.use()
		if equiped_item:
			equipUse()
		else:
			use()

func equipUse():
	equiped_item_script.use(self)

func use(p_params = {}):
	for iter_node in detectFront():
		if iter_node.is_in_group("Interactable"):
			iter_node.get_node("MAIN").triggered(p_params)
	pass

func detectFront():
	var temp_bodies = pickup_hitbox.get_overlapping_bodies()
	temp_bodies.append_array(pickup_hitbox.get_overlapping_areas())
	return temp_bodies

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
	for node in detectFront():
		if node.is_in_group("item"):
			pickup(node)
			return

func pickup(p_node: Node):
	animator.hold(true)
	p_node.reparent(itemHolder)
	equiped_item = p_node
	equiped_item_script = p_node.get_node("MAIN")
	p_node.remove_from_group("item")

	movement_manager.item_mul = equiped_item_script.speed_factor
	equiped_item_script.initalise(self)

func getLabel1():
	return cursor_label_1

func getLabel2():
	return cursor_label_2

func getCursorHandler():
	return cursor_handler

func getCamShaker():
	return cam_shaker
