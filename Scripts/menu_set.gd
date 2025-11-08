extends CheckBox

@export var globa_value: String

func _ready() -> void:
	toggled.connect(clicked)

func clicked(mode):
	global[globa_value] = mode
