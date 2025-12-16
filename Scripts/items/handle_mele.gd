class_name handle_mele extends Node

@export var mele_hitbox: Area3D
@export var mele_dmg: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mele_hitbox.body_entered.connect(check_hitbox)

func check_hitbox(body: Node3D):
	print(body)
	if body.has_method("mele_hit"): 
		body.mele_hit(mele_dmg)
