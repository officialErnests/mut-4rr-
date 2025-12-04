extends Node3D

var npc_list = []

func _ready():
	initNpcList()
	await get_tree().create_timer(1).timeout
	updateNpcs()

func updateNpcs():
	for iter_npc in npc_list:
		iter_npc.update()

func initNpcList():
	for iter_npc in get_children():
		npc_list.append(iter_npc)
