extends Node

enum ItemType {
	GUN,
}

@export var itemRigid: RigidBody3D
@export var type: ItemType
@export var speed_factor: float
@export_category("GUN")
@export var gun_handle: Handle

func initalise(p_main):
	itemRigid.freeze = true
	itemRigid.transform = Transform3D.IDENTITY
	match type:
		ItemType.GUN:
			gun_handle.cursor_handler = p_main.getCursorHandler()
			gun_handle.cam_shaker = p_main.getCamShaker()
			gun_handle.enabled = true
	return speed_factor

func drop() -> void:
	match type:
		ItemType.GUN:
			gun_handle.enabled = false