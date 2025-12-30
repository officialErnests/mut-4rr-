extends StaticBody3D

var broken = false
func _ready() -> void:
	global.statueAdd()

@export var animator: AnimationPlayer
func mele_hit(dmg: float):
	if broken: return
	broken = true
	global.statueRemove()
	animator.play("TAKEDOWN")
