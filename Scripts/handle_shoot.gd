class_name Handle extends NB_script

@export var light: Node3D
@export var light_pt2: Node3D
@export var hiddens: Node3D
var cursor_handler: Node
var cam_shaker: Node
var timer = 0
var flash_timer = 0
var delay = 0

var TEMP_AMMO = 10
var MAIN: Node

func _process(delta: float) -> void:
	if not enabled: return
	if Input.is_action_pressed("shoot") and delay <= 0:
		light.visible = true
		light_pt2.visible = true
		hiddens.visible = false
		flash_timer = 0.01
		timer = 0.01
		delay = 0.02
		cursor_handler.instaSet()
		cam_shaker.shot(1)
		MAIN.setCursorText("AMMO: " + str(TEMP_AMMO) + " - ")
		TEMP_AMMO -= 1
	elif flash_timer > 0:
		flash_timer -= delta
	elif timer > 0:
		light_pt2.visible = false
		timer -= delta
	else:
		delay -= delta
		light_pt2.visible = false
		light.visible = false
		hiddens.visible = true
