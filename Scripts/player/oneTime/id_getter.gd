extends CharacterBody3D
var id := -1
func  _ready() -> void:
	id = global.declareCharecter(self)
