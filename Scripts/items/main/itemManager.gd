extends Node

@export var itemHolder: Node3D
@export var animator: Node
@export var pickup_hitbox: Area3D
@export var cursor_handler: Node
@export var cam_shaker: Node
@export var movement_manager: Node
@export var pickup_orgin: Marker3D
# Specificly this project ;))
@export var cursor_label_1 : Label3D
@export var cursor_label_2 : Label3D

var equiped_item: RigidBody3D= null
var equiped_item_script: Node = null
func _ready() -> void:
	pass # Replace with function body.

func nbThrow():
	animator.use()
	if equiped_item:
		throw()
	else:
		pickupDetect()

func nbUse():
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
	equiped_item.collision_layer = 1

	movement_manager.item_mul = 1

	equiped_item = null
	equiped_item_script = null

func pickupDetect():
	var closest_item = null
	var closest_item_distnace = -1
	for node in detectFront():
		if node.is_in_group("item"):
			var temp_distance = itemHolder.global_position.distance_to(node.global_position)
			if not closest_item:
				closest_item = node
				closest_item_distnace = temp_distance
			if temp_distance < closest_item_distnace:
				closest_item = node
				closest_item_distnace = temp_distance
	if closest_item: pickup(closest_item)
	return

func pickup(p_node: Node):
	animator.hold(true)
	p_node.reparent(itemHolder)
	equiped_item = p_node
	equiped_item_script = p_node.get_node("MAIN")
	p_node.remove_from_group("item")

	movement_manager.item_mul = equiped_item_script.speed_factor
	equiped_item.collision_layer = 0
	equiped_item_script.initalise(self)

func getLabel1():
	return cursor_label_1

func getLabel2():
	return cursor_label_2

func getCursorHandler():
	return cursor_handler

func getCamShaker():
	return cam_shaker

func getHitbox():
	return pickup_hitbox