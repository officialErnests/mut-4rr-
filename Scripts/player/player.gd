extends Node

@export var charecter: CharacterBody3D
@export var rotator: Node3D
@export var ground_snaper: Node3D
const SPEED = 2.0
const JUMP_VELOCITY = 4.5
var item_mul = 1
var camera_to_angle = 45
var mouse_turning = false

func _physics_process(delta: float) -> void:
	gravity(delta)
	rotate_cam(delta)
	if ground_snaper: snapToGround()
	movement()
	charecter.move_and_slide()

func snapToGround():
	var bigest_snap = null
	for temp_ground_snaper in ground_snaper.get_children():
		if temp_ground_snaper.is_colliding():
			var temp_y = temp_ground_snaper.get_collision_point().y 
			if not bigest_snap or bigest_snap < temp_y:
				bigest_snap = temp_y
	if bigest_snap: charecter.global_position.y = bigest_snap

func gravity(delta):
	if not charecter.is_on_floor():
		charecter.velocity += charecter.get_gravity() * delta

func rotate_cam(delta):
	if global.cam_controll_qe:
		if Input.is_action_just_pressed("rot_cam_left"):
			camera_to_angle += 45
		if Input.is_action_just_pressed("rot_cam_right"):
			camera_to_angle -= 45
	if global.cam_controll_mouse:
		var mouse_procentualy = get_viewport().get_mouse_position().x / get_viewport().get_visible_rect().size.x
		if mouse_procentualy < 0.2:
			if not mouse_turning:
				mouse_turning = true
				camera_to_angle += 90
		elif mouse_procentualy > 0.8:
			if not mouse_turning:
				mouse_turning = true
				camera_to_angle -= 90
		else:
			mouse_turning = false
	rotator.rotation_degrees.y += (camera_to_angle - rotator.rotation_degrees.y) * delta

func movement():
	var input_dir := Input.get_vector("left", "right", "forward", "backward")

	var direction := (rotator.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed_mul = 2 if Input.is_action_pressed("sprint") else 1
	if direction:
		charecter.velocity.x = direction.x * SPEED * speed_mul * item_mul
		charecter.velocity.z = direction.z * SPEED * speed_mul * item_mul
	else:
		charecter.velocity.x = move_toward(charecter.velocity.x, 0, SPEED)
		charecter.velocity.z = move_toward(charecter.velocity.z, 0, SPEED)
