extends Label3D


@onready var parent_npc = $".."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not visible: return
	drawHp(0)
	parent_npc.hp_update.connect(drawHp)

func drawHp(dmg: float):
	text = "["
	# print(parent_npc.hp, parent_npc.hp_max)
	for i in range(ceil(parent_npc.hp / parent_npc.hp_max * 10)):
		text += "#"
	for i in range(floor((parent_npc.hp_max - parent_npc.hp)/ parent_npc.hp_max * 10)):
		text += "*"
	text += "]"