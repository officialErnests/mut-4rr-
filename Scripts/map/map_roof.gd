class_name building_roof extends Node3D

@export var player_closenes = -1
@export var visible_distance = 1
@export var light_distance = 1
@export var start_room = false
@export var neibour_roofs: Array[building_roof]

@export var visual :MeshInstance3D
@export var trigger :Area3D  
@export var light: Node3D
var update_step = 0
var seek_step = 0


func _ready() -> void:
	trigger.body_entered.connect(roomEntered)
	trigger.body_exited.connect(roomExited)
	if start_room:
		player_closenes = 0
		updateRoof()
		expandZero(0, update_step + 1)

func roomEntered(body) -> void:
	if body.is_in_group("Player"):
		player_closenes = 0
		updateRoof()
		expandZero(0, update_step + 1)

func roomExited(body) -> void:
	if body.is_in_group("Player"):
		player_closenes = 1
		# player_closenes = -1
		updateRoof()
		# seekZero(seek_step + 1)
	
func expandZero(p_value, p_update_step) -> void:
	if update_step == p_update_step:
		if player_closenes >= p_value:
			player_closenes = p_value
			updateRoof()
			for roof in neibour_roofs:
				roof.expandZero(p_value + 1, p_update_step)
		return
	
	update_step = p_update_step
	if player_closenes == 0:
		for roof in neibour_roofs:
			roof.expandZero(1, p_update_step)
		return
	player_closenes = p_value
	updateRoof()
	for roof in neibour_roofs:
		roof.expandZero(p_value + 1, p_update_step)

func seekZero(p_seek_step) -> int:
	if seek_step == p_seek_step:
		return -1
	if player_closenes == 0:
		return 1
	
	player_closenes = -1
	seek_step = p_seek_step
	updateRoof()
	var max_val = -1
	for roof in neibour_roofs:
		var variable_return = roof.seekZero(p_seek_step)
		if max_val == -1:
			max_val = variable_return
		if variable_return < max_val and not variable_return == -1:
			max_val = variable_return
	if max_val != -1:
		player_closenes = max_val
		updateRoof()
		return max_val + 1
	return -1

func updateRoof():
	if player_closenes > light_distance or player_closenes == -1:
		light.visible = false
	else:
		light.visible = true
	if player_closenes > visible_distance or player_closenes == -1:
		visual.material_override.distance_fade_mode = BaseMaterial3D.DistanceFadeMode.DISTANCE_FADE_DISABLED
	else:
		visual.material_override.distance_fade_mode = BaseMaterial3D.DistanceFadeMode.DISTANCE_FADE_PIXEL_DITHER
