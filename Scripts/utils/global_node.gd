class_name  globalizator extends NB_script

@export var global_name:String
@export var node_to_globalize:Node

func _ready() -> void: 
	if enabled: 
		global.global_nodes[global_name] = node_to_globalize