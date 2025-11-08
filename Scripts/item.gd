@tool
extends Node

enum ItemType {
	GUN
}
var classes
var typess: ItemType
var testing: bool
func _get_property_list() -> Array:
	var properties: Array = []
	if ItemType.GUN:
		properties.append({
			"name": "typess",
			"type": TYPE_NIL,
			"usage": PROPERTY_USAGE_CATEGORY,
		})
	return properties

func initalise(p_main):
	pass