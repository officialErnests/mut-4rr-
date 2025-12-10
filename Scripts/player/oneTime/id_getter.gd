class_name NB_ID_GET extends Node

@export var main_node: Node3D
var id := -1
func  _ready() -> void:
	id = global.declareCharecter(main_node)
	main_node.set_meta("ID", id)
