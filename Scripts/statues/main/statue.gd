extends StaticBody3D

@export var animator: AnimationPlayer
func mele_hit(dmg: float):
	animator.play("TAKEDOWN")
