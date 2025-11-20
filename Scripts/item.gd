extends Node

enum ItemType {
	GUN,
}

@export var itemRigid: RigidBody3D
@export var type: ItemType
@export var speed_factor: float
@export var visual_outside: MeshInstance3D
@export var show_text:String
@export_category("GUN")
@export var gun_handle: Handle

var cursor_label_1 : Label3D = null
var cursor_label_2 : Label3D = null

var item_equiped = false

func initalise(p_main):
	item_equiped = true
	itemRigid.freeze = true
	itemRigid.transform = Transform3D.IDENTITY
	cursor_label_1 = p_main.getLabel1()
	cursor_label_2 = p_main.getLabel2()
	
	match type:
		ItemType.GUN:
			gun_handle.MAIN = self
			gun_handle.cursor_handler = p_main.getCursorHandler()
			gun_handle.cam_shaker = p_main.getCamShaker()
			gun_handle.enabled = true
	return speed_factor

func setCursorText(p_text):
	cursor_label_1.curent_text = p_text
	cursor_label_2.curent_text = p_text

func _process(delta):
	visual_outside.material_overlay.grow_amount += ((0.02 if item_equiped else 0.001) - visual_outside.material_overlay.grow_amount) * delta * 8
	
func drop() -> void:
	item_equiped = false
	itemRigid.freeze = false
	match type:
		ItemType.GUN:
			gun_handle.cursor_handler = null
			gun_handle.cam_shaker = null
			gun_handle.enabled = false
			itemRigid.linear_velocity = -itemRigid.global_basis.z * 10
