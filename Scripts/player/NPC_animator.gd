extends Node3D

@export var animation_tree: AnimationTree
@export var skeleton: Skeleton3D

enum AnimationStates {
	RUN,
	WALK,
	IDLE
}
func updateAnimation(p_state):
	animation_tree["parameters/StateMachine/conditions/idle"] = p_state == AnimationStates.IDLE
	animation_tree["parameters/StateMachine/conditions/run"] = p_state == AnimationStates.RUN
	animation_tree["parameters/StateMachine/conditions/walk"] = p_state == AnimationStates.WALK

func hold(p_true):
	if p_true:
		animation_tree["parameters/Add2/add_amount"] = 1
	else:
		animation_tree["parameters/Add2/add_amount"] = 0

func use():
	animation_tree["parameters/TimeSeek/seek_request"] = 0

func getHeadTrans():
	return skeleton.to_global(skeleton.get_bone_global_pose(3).origin)
