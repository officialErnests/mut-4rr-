extends Label3D

@onready var parent_npc = $".."

func _ready() -> void:
	if not visible: return
	drawText()
	parent_npc.memUpdate.connect(drawText)

func drawText():
	text = ""
	for iter_idea in range(parent_npc.seen_objects.size()):
		var item = parent_npc.seen_objects[iter_idea]
		text += str(enums.ItemType.keys()[item.item.type]) + "\n"
	text += "^ BRAINS ^"
