class_name Handle_gun extends NB_script

@export var light: Node3D
@export var light_pt2: Node3D
@export var hiddens: Node3D
@export var shoot_point: Node3D
@export_category("Dellay stuff")
@export var light_time: float = 0.05
@export var flash_time: float = 0.01
@export var delay : float = 0.1
@export_category("Gun misc")
@export var max_ammo: int
@export_category("Shooting")
@export var shot_range: float = 10.0
@export var shot_damage: float
@export_category("DEBUG")
@export var hit_marker: Node3D

var curent_ammo :int
var cursor_handler: Node
var cam_shaker: Node
var light_countdown_timer = 0
var MAIN: Node

func  _ready() -> void:
	curent_ammo = max_ammo

func _process(delta: float) -> void:
	if light_countdown_timer <= 0: return
	light_countdown_timer -= delta
	if light_countdown_timer <= delay - light_time:
		light.visible = false
		light_pt2.visible = false 
		hiddens.visible = true
	elif light_countdown_timer <= delay + light_time - flash_time:
		light_pt2.visible = false

func setAmmoString():
	MAIN.setCursorText("AMMO: " + str(curent_ammo) + " // ")

func use():
	if light_countdown_timer > 0: return
	
	#What is ammo XD
	if curent_ammo <= 0:return
	curent_ammo -= 1
	setAmmoString()

	cursor_handler.instaSet()
	cam_shaker.shot(1)
	light_countdown_timer = light_time + delay
	light.visible = true
	light_pt2.visible = true
	hiddens.visible = false
	var raycast_results = castRay(shoot_point.global_position,
							-shoot_point.global_basis.z * shot_range + shoot_point.global_position,
							255)
	if raycast_results.has("collider"):
		if hit_marker: hit_marker.global_position = raycast_results["position"]
		if raycast_results["collider"].has_method("shot_hit"): 
			raycast_results["collider"].shot_hit(shot_damage)
			# print("SHOT HIT")

func castRay(start_position: Vector3, p_end_position :Vector3, p_collision_layer: int) -> Dictionary:
	var ray_point_start = start_position
	var ray_point_end = p_end_position

	var space_state = get_viewport().find_world_3d().direct_space_state
	# floor - 32
	# wall - 16
	var params = PhysicsRayQueryParameters3D.create(ray_point_start, ray_point_end, p_collision_layer)

	return space_state.intersect_ray(params)

func getAmmo() -> int:
	return curent_ammo