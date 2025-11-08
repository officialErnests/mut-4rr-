extends Node

@export var itemHolder: Node3D
@export var animator: Node
@export var pickup_hitbox: Area3D

var equiped_item = null
var equiped_item_script = null
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pickupDetect():
	var hit_nodes = pickup_hitbox.get_overlapping_bodies()
	for node in hit_nodes:
		if node.is_in_group("item"):
			pickup(node)
			return

func pickup(p_node: Node):
	itemHolder.add_child(p_node)
	equiped_item = p_node
	equiped_item_script = p_node.get_node("MAIN")

	equiped_item_script.initalise(self)
