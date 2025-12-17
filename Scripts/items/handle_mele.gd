class_name handle_mele extends Node

@export var mele_hitbox: Area3D
@export var mele_dmg: float

var holder_hitbox: Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mele_hitbox.body_entered.connect(damage_body)

func damage_body(body: Node3D):
	if body.has_method("mele_hit"): 
		body.mele_hit(mele_dmg)

func update_hitbox(p_new_hitbox: Area3D):
	print("HITBOX SET")
	holder_hitbox = p_new_hitbox

func use():
	for hit_body in holder_hitbox.get_overlapping_bodies():
		damage_body(hit_body)
