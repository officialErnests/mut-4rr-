extends NB_script

@export var npc_speed:= 2
@export var naviagtion_agent : NavigationAgent3D
@export var rigid_body : RigidBody3D
@export var body: Node3D
@export var clamper: RayCast3D
@export var ground: RayCast3D
var running := false
var is_in_action = false
var item_mul = 1
signal done_moving

func _physics_process(delta: float) -> void:
	if not enabled: return
	if not naviagtion_agent.is_navigation_finished():
		var nextPos = naviagtion_agent.get_next_path_position()
		rigid_body.look_at(nextPos)
		rigid_body.rotation.x = 0
		rigid_body.rotation.z = 0
		
		if rigid_body.position.distance_to(nextPos) > 0.5 and ground.is_colliding():
			var normal = (naviagtion_agent.get_next_path_position() - rigid_body.global_position).normalized() * npc_speed
			rigid_body.linear_velocity.x = normal.x * (2 if running else 1) * item_mul
			rigid_body.linear_velocity.z = normal.z * (2 if running else 1) * item_mul
			if clamper.is_colliding():
				var temp_y = clamper.get_collision_point().y 
				rigid_body.global_position.y = temp_y
			if (running):
				body.updateAnimation(body.AnimationStates.RUN)
			else:
				body.updateAnimation(body.AnimationStates.WALK)
		else:
			body.updateAnimation(body.AnimationStates.IDLE)
	else:
		if is_in_action:
			is_in_action = false
			done_moving.emit()
		body.updateAnimation(body.AnimationStates.IDLE)

func walkTo(p_position : Vector3) -> void:
	running = false
	moveTo(p_position)

func runTo(p_position: Vector3) -> void:
	running = true
	moveTo(p_position)

func moveTo(p_position : Vector3) -> void:
	is_in_action = true
	naviagtion_agent.set_target_position(p_position)
