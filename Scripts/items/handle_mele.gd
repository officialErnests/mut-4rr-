class_name handle_mele extends Node

@export var mele_hitbox: Area3D
@export var mele_dmg: float
@export var knife: RigidBody3D

var holder_hitbox: Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	knife = get_parent()
	mele_hitbox.body_entered.connect(throwDmg)

func damage_body(body: Node3D):
	if body.has_method("mele_hit"): 
		body.mele_hit(mele_dmg)

func dmgBodyMul(body: Node3D, p_mul: int) -> void:
	if body.has_method("mele_hit"): 
		body.mele_hit(mele_dmg * p_mul)

func update_hitbox(p_new_hitbox: Area3D):
	# print("HITBOX SET")
	holder_hitbox = p_new_hitbox

func throwDmg(body: Node3D) -> void:
	var knife_speed = abs(knife.linear_velocity.length())
	if knife_speed > 1:
		dmgBodyMul(body, knife_speed)

func use():
	for hit_body in holder_hitbox.get_overlapping_bodies():
		damage_body(hit_body)
