extends Label3D

@onready var parent_npc = $".."

func _ready() -> void:
	drawText()
	parent_npc.toughUpdate.connect(drawText)

func drawText():
	text = ""
	var curent_idea = parent_npc.curent_idea_index
	for iter_idea in range(parent_npc.priority_list.size()):
		var idea = str(parent_npc.priority_list[iter_idea])
		text += ("> " if curent_idea == iter_idea else "- ") + str(idea) + "\n"
	text += "^ BRAINS ^"

