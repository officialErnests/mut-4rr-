extends NB_script

@export var npc_speed:= 100
@export var naviagtion_agent : NavigationAgent3D
@export var rigid_body : RigidBody3D
var next_navigation_pos : Vector3

func _ready() -> void:
	pass

#TODO make npc walk n shit
func _physics_process(delta: float) -> void:
	rigid_body.look_at(next_navigation_pos)
	rigid_body.rotation.x = 0
	rigid_body.rotation.z = 0

	if rigid_body.position.distance_to(next_navigation_pos) > 0.5:
		var normal = (naviagtion_agent.get_next_path_position() - rigid_body.global_position).normalized() * npc_speed
		rigid_body.linear_velocity += normal
	
	

func moveTo(p_position : Vector3) -> void:
	naviagtion_agent.set_target_position(p_position)