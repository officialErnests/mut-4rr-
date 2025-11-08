extends Node

@export var charecter: CharacterBody3D
@export var rotator: Node3D
const SPEED = 2.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not charecter.is_on_floor():
		charecter.velocity += charecter.get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (rotator.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed_mul = 2 if Input.is_action_pressed("sprint") else 1
	if direction:
		charecter.velocity.x = direction.x * SPEED * speed_mul
		charecter.velocity.z = direction.z * SPEED * speed_mul
	else:
		charecter.velocity.x = move_toward(charecter.velocity.x, 0, SPEED)
		charecter.velocity.z = move_toward(charecter.velocity.z, 0, SPEED)


	charecter.move_and_slide()
