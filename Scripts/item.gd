extends Node

enum ItemType {
	GUN,
}

@export var itemRigid: RigidBody3D
@export var type: ItemType

@export_category("GUN")
@export var handle: Node

func initalise(p_main):
	itemRigid.freeze = true
	itemRigid.transform = Transform3D.IDENTITY
	match type:
		ItemType.GUN:
			handle.cursor_handler = p_main.getCursorHandler()
			handle.cam_shaker = p_main.getCamShaker()
			handle.enabled = true
