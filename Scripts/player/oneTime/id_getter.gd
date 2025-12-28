extends CharacterBody3D
var id := -1
@export var blinker: AnimationTree
func  _ready() -> void:
	id = global.declareCharecter(self)
	#TODO set thsi to 100 or better value ;PP
	var i_max: float = 20.0
	for i in range(i_max + 1):
		await get_tree().create_timer(0.05).timeout
		blinker.set("parameters/blend_position", min(cos(i * 0.2) * 0.1 + (i / i_max), 1))
	blinker.set("parameters/blend_position", 1)