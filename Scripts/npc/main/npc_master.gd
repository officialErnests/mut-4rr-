extends Node3D

var npc_list = []

func _ready():
	initNpcList()
	updateNpcs()

func updateNpcs():
	for npc in npc_list:
		npc.update()

func initNpcList():
	for npc in get_children():
		npc_list.append(npc)
