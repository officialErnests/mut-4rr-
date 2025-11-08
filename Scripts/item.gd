extends Node

enum ItemType {
	GUN,
}

@export var type: ItemType

@export_category("GUN")
@export

func initalise(p_main):
	match type:
		ItemType.GUN:
			pass