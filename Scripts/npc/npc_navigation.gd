extends NB_script

@export var npc_speed:= 2
@export var naviagtion_agent : NavigationAgent3D
@export var rigid_body : RigidBody3D
@export var body: Node3D

func _ready() -> void:
	moveTo(Vector3(0,0,0))

#TODO make npc walk n shit
func _physics_process(delta: float) -> void:
	if not naviagtion_agent.is_navigation_finished():
		var nextPos = naviagtion_agent.get_next_path_position()
		rigid_body.look_at(nextPos)
		rigid_body.rotation.x = 0
		rigid_body.rotation.z = 0

		if rigid_body.position.distance_to(nextPos) > 0.5:
			var normal = (naviagtion_agent.get_next_path_position() - rigid_body.global_position).normalized() * npc_speed
			rigid_body.linear_velocity.x = normal.x
			rigid_body.linear_velocity.z = normal.z
			body.updateAnimation(body.AnimationStates.WALK)
	else:
		body.updateAnimation(body.AnimationStates.IDLE)

		
	
	

func moveTo(p_position : Vector3) -> void:
	naviagtion_agent.set_target_position(p_position)
