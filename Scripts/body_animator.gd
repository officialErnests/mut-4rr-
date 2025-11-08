extends Node

@export var main_body: PhysicsBody3D
@export var animator: Node
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_body.velocity.y != 0:
		animator.updateAnimation(animator.AnimationStates.IDLE)
	elif main_body.velocity.length() > 3:
		animator.updateAnimation(animator.AnimationStates.RUN)
	elif main_body.velocity.length() > 0:
		animator.updateAnimation(animator.AnimationStates.WALK)
	else:
		animator.updateAnimation(animator.AnimationStates.IDLE)
