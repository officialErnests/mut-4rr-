class_name building_roof extends Node3D

@export var player_closenes = -1
@export var visible_distance = 1
@export var light_distance = 1
@export var neibour_roofs: Array[building_roof]

@onready var visual :MeshInstance3D= $Visual
@onready var trigger :Area3D = $Trigger
@onready var light: Light3D = $Visual/SpotLight3D
var update_step = 0
var seek_step = 0

func _ready() -> void:
	trigger.body_entered.connect(roomEntered)
	trigger.body_exited.connect(roomExited)

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
	debug()
	if player_closenes > light_distance or player_closenes == -1:
		light.visible = false
	else:
		light.visible = true

func debug():
	$Label3D.text = str(player_closenes)
