class_name building_roof extends Node3D

@export var player_closenes = -1
@export var light_distance = 1
@export var neibour_roofs: Array[building_roof]

@onready var visual :MeshInstance3D= $Visual
@onready var trigger :Area3D = $Trigger
var update_step = 0
var seek_step = 0

func _ready() -> void:
	trigger.body_entered.connect(roomEntered)
	trigger.body_exited.connect(roomExited)
	debug()

func roomEntered(body) -> void:
	if body.is_in_group("Player"):
		player_closenes = 0
		spreadUpdate(update_step + 1, player_closenes)

func roomExited(body) -> void:
	if body.is_in_group("Player"):
		player_closenes = -1
		seekUpdate(seek_step + 1)

func spreadUpdate(s_update_step, value) -> void:
	if update_step == s_update_step:
		debug()
		return
	update_step = s_update_step

	if not player_closenes == 0:
		player_closenes = value + 1
		debug()
		return
	else:
		for iter_roof in neibour_roofs:
			iter_roof.spreadUpdate(s_update_step, value + 1)
		debug()

func seekUpdate(s_update_step) -> bool:
	if player_closenes == 0:
		spreadUpdate(update_step + 1, player_closenes)
		debug()
		return true
	if s_update_step != seek_step:
		s_update_step = seek_step
		
		for iter_roof in neibour_roofs:
			if await iter_roof.seekUpdate(s_update_step): return true
	debug()
	return false

func debug():
	$Label3D.text = str(player_closenes)
