extends Node

@export var item_manager: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if item_manager:
		if Input.is_action_just_pressed("throw"): item_manager.nbThrow()
		if Input.is_action_just_pressed("use"): item_manager.nbUse()
