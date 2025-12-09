class_name NB_item extends Node

@export var itemRigid: RigidBody3D
@export var type: enums.ItemType
@export var type_id := 0
@export var speed_factor: float
@export var visual_outside: GeometryInstance3D
@export var show_text:String
@export var throw_force: float = 5
@export var extend_script: Node

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
		enums.ItemType.GUN:
			extend_script.MAIN = self
			extend_script.cursor_handler = p_main.getCursorHandler()
			extend_script.cam_shaker = p_main.getCamShaker()
			extend_script.enabled = true

	return speed_factor

func setCursorText(p_text):
	cursor_label_1.curent_text = p_text
	cursor_label_2.curent_text = p_text

func _process(delta):
	visual_outside.material_overlay.grow_amount += ((2.0 if item_equiped else 0.1) - visual_outside.material_overlay.grow_amount) * delta * 8

func use(p_main) -> void:
	match type:
		enums.ItemType.GUN:
			extend_script.shoot()
		enums.ItemType.KEY:
			p_main.use(getParams())
		_:
			p_main.use()

func getParams():
	return get_parent().params

func getType():
	return type

func drop() -> void:
	item_equiped = false
	itemRigid.freeze = false
	itemRigid.linear_velocity = -itemRigid.global_basis.z * throw_force
	match type:
		enums.ItemType.GUN:
			extend_script.cursor_handler = null
			extend_script.cam_shaker = null
			extend_script.enabled = false
