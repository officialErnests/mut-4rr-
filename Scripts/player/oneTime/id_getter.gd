class_name NB_ID_GET extends NB_item

@export var main: Node3D
var id := -1
func  _ready() -> void:
	id = global.declareCharecter(main)
	main.set_meta("ID", id)
