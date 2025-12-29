extends Button

@export var seed_input_box: LineEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(clicked)

func clicked():
	global.play(seed_input_box.text)
