extends Node3D

@export var animation_tree: AnimationTree

enum AnimationStates {
	RUN,
	WALK,
	IDLE
}

func updateAnimation(p_state):
	animation_tree["parameters/StateMachine/conditions/idle"] = p_state == AnimationStates.IDLE
	animation_tree["parameters/StateMachine/conditions/run"] = p_state == AnimationStates.RUN
	animation_tree["parameters/StateMachine/conditions/walk"] = p_state == AnimationStates.WALK