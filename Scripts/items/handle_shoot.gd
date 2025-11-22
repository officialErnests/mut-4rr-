class_name Handle extends NB_script

@export var light: Node3D
@export var light_pt2: Node3D
@export var hiddens: Node3D
@export var light_time: float
@export var flash_time: float
@export var delay : float
@export var max_ammo: int

var curent_ammo = max_ammo
var cursor_handler: Node
var cam_shaker: Node
var light_countdown_timer = 0
var MAIN: Node

func _process(delta: float) -> void:
	if light_countdown_timer <= 0: return
	light_countdown_timer -= delta

	if light_countdown_timer <= delay - light_time - flash_time :
		light.visible = false
		light_pt2.visible = false 
		hiddens.visible = true
	elif light_countdown_timer <= delay + light_time - flash_time:
		light_pt2.visible = false 

func setAmmoString():
	MAIN.setCursorText("AMMO: " + str(curent_ammo) + " // ")

func shoot():
	if light_countdown_timer > 0: return
	setAmmoString()
	cursor_handler.instaSet()
	cam_shaker.shot(1)
	light_countdown_timer = light_time + delay
	light.visible = true
	light_pt2.visible = true
	hiddens.visible = false
