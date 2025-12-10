extends Node

class Item:
	var type: enums.ItemType
	var params: Dictionary
	func _init(p_object_of_intrest: enums.ItemType, p_object_params: Dictionary) -> void:
		type = p_object_of_intrest
		params = p_object_params
	func _to_string() -> String:
		return enums.ItemType.keys()[type] + " | " + global.dicToString(params)
	