extends Node3D

var npc_list = []

func _ready():
	initNpcList()
	await get_tree().create_timer(1).timeout
	updateNpcs()
	while true:
		await get_tree().create_timer(1).timeout
		if not is_inside_tree(): return
		if not get_tree(): return
		updateNpcs()

func updateNpcs():
	for iter_npc in npc_list:
		if iter_npc: iter_npc.update()

func initNpcList():
	for iter_npc in get_children():
		npc_list.append(iter_npc)
