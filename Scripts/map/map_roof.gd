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
	
func roomEntered(body) -> void:
	if body.is_in_group("Player"):
		player_closenes = 0
		expandZero(0, update_step + 1)

func roomExited(body) -> void:
	if body.is_in_group("Player"):
		player_closenes = -1
		seekZero(seek_step + 1)
	
func expandZero(p_value, p_update_step) -> void:
	if update_step == p_update_step:
		if player_closenes >= p_value:
			player_closenes = p_value
			print("AHHHHHHHHHHHH")
			for roof in neibour_roofs:
				roof.expandZero(p_value + 1, p_update_step)
		return
		
	update_step = p_update_step
	player_closenes = p_value
	for roof in neibour_roofs:
		roof.expandZero(p_value + 1, p_update_step)

func seekZero(p_seek_step) -> void:
	if seek_step == p_seek_step:
		return
	player_closenes = -1
	seek_step = p_seek_step
	for roof in neibour_roofs:
		roof.seekZero(p_seek_step)