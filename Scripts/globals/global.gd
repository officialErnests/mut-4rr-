extends Node

var cam_controll_qe = true
var cam_controll_mouse = true

var main_item_holder: Node3D

var global_nodes = {}

func arrToStr(p_input_arr, p_indent) -> String:
	var result_string = repeatString("\t", p_indent) + "["
	for iter_string in p_input_arr:
		result_string += "\n\t" + repeatString("\t", p_indent) + str(iter_string)
	result_string += "\n" + repeatString("\t", p_indent) +  "]"
	return result_string

func dicToString(p_dictionary) -> String:
	var result_string = ""
	for key in p_dictionary.keys():
		result_string += key + ": "
		result_string += str(p_dictionary[key]) + " "
	return result_string

func repeatString(p_string, p_times) -> String:
	var result = ""
	for x in range(p_times): result += p_string
	return result

# time
var time_now := 0
func _ready() -> void:
	while true:
		await get_tree().create_timer(1).timeout
		time_now += 1
func getTime() -> int:
	return time_now

# npc
var next_charecter_id := 0
var charecter_ids : Array[Node3D]
func declareCharecter(p_npc: Node3D) -> int:
	charecter_ids.push_back(p_npc)
	next_charecter_id += 1
	return next_charecter_id - 1

# item
var next_item_id := 0
var item_ids : Array[Node3D]
func declareItem(p_item: Node3D) -> int:
	item_ids.push_back(p_item)
	next_item_id += 1
	return next_item_id - 1

#check if array contains obj
func checkArrayID(p_array: Array, p_id: int) -> int:
	var index := 0
	for element in p_array:
		if element.id == p_id:
			return index 
		index += 1
	return -1