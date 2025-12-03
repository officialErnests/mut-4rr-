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

func repeatString(p_string, p_times) -> String:
	var result = ""
	for x in range(p_times): result += p_string
	return result
